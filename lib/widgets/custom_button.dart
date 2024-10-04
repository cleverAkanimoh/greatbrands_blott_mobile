import 'package:greatbrands_blott_mobile/app_config.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  final Color? color;
  final Color? textColor;
  final double? height;
  final double? width;
  final double? borderRadius;

  const CustomButton({
    super.key,
    this.onTap,
    required this.title,
    this.color,
    this.textColor,
    this.height,
    this.width,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(borderRadius ?? roundedFull),
      child: Container(
        height: height ?? 48,
        width: width,
        padding: EdgeInsets.symmetric(horizontal: extraSmallWhiteSpace),
        decoration: _buildButtonDecoration(),
        child: Center(
          child: _buildButtonText(),
        ),
      ),
    );
  }

  // Extract decoration for reuse or easier customization
  BoxDecoration _buildButtonDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(borderRadius ?? roundedFull),
      color: color ?? primaryColor,
    );
  }

  // Extract text styling for reusability and clarity
  Text _buildButtonText() {
    return Text(
      title,
      style: TextStyle(
        color: textColor ?? whiteColor,
        fontWeight: FontWeight.bold,
        fontSize: paragraphText,
      ),
    );
  }
}
