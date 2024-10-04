import 'package:greatbrands_blott_mobile/app_config.dart';
import 'package:greatbrands_blott_mobile/helpers/navigator_push.dart';
import 'package:greatbrands_blott_mobile/helpers/user.dart';
import 'package:greatbrands_blott_mobile/screens/notification.dart';
import 'package:greatbrands_blott_mobile/styles.dart';
import 'package:greatbrands_blott_mobile/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LegalName extends StatefulWidget {
  const LegalName({super.key});

  @override
  State<LegalName> createState() => _LegalNameState();
}

class _LegalNameState extends State<LegalName> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  bool isFormFilled = false;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
    _addInputListeners();
  }

  @override
  void dispose() {
    // Disposed controllers to prevent memory leaks
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  // Load stored user info and populate input fields
  Future<void> _loadUserInfo() async {
    String storedFirstName = await User.getFirstName();
    String storedLastName = await User.getLastName();

    if (storedFirstName.isNotEmpty && storedLastName.isNotEmpty) {
      setState(() {
        firstNameController.text = storedFirstName;
        lastNameController.text = storedLastName;
      });
    }
  }

  // Add listeners to input fields to detect form completion
  void _addInputListeners() {
    firstNameController.addListener(_validateForm);
    lastNameController.addListener(_validateForm);
  }

  // Check if both fields are filled and update the form state
  void _validateForm() {
    setState(() {
      isFormFilled = firstNameController.text.isNotEmpty &&
          lastNameController.text.isNotEmpty;
    });
  }

  // Save user info and navigate to notification screen if form is valid
  Future<void> _onSubmit() async {
    if (isFormFilled) {
      final String formattedFirstName = firstNameController.text
              .trim()
              .split(" ")
              .first
              .toLowerCase()
              .capitalizeFirst ??
          "";
      final String formattedLastName = lastNameController.text
              .trim()
              .split(" ")
              .first
              .toLowerCase()
              .capitalizeFirst ??
          "";

      await User.saveUserInfo(formattedFirstName, formattedLastName);
      NavigatorPush.push(context, const BlottNotification());
    }
  }

  // Build the input fields UI
  Widget _buildInputFields() {
    return Column(
      children: [
        InputField(
          controller: firstNameController,
          placeholder: "First Name",
        ),
        SizedBox(height: whiteSpace),
        InputField(
          controller: lastNameController,
          placeholder: "Last Name",
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: isFormFilled ? primaryColor : tertiaryColor,
        shape: const CircleBorder(),
        elevation: 0,
        onPressed: _onSubmit,
        child: const Icon(
          Icons.chevron_right,
          color: Colors.white,
          size: 40,
        ),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: EdgeInsets.all(smallWhiteSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Your legal name", style: headingStyle),
                SizedBox(height: whiteSpace),
                Text(
                  "We need to know a bit about you so that we can create your account.",
                  style: paragraphStyle,
                ),
                SizedBox(height: whiteSpace),
                _buildInputFields(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
