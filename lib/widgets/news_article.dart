import 'package:greatbrands_blott_mobile/app_config.dart';
import 'package:greatbrands_blott_mobile/helpers/formatters.dart';
import 'package:greatbrands_blott_mobile/models/news_article.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher.dart';

class News extends StatefulWidget {
  final NewsArticle article;
  final bool isLoading;

  const News({
    super.key,
    required this.article,
    this.isLoading = false,
  });

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  // This method is moved outside the build method for better structure.
  Future<void> _readNews() async {
    final Uri uri = Uri.tryParse(widget.article.url) ?? Uri();

    if (uri.scheme.isEmpty) {
      // Handle invalid URL cases
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid news URL')),
      );
      return;
    }

    if (!await launchUrl(uri)) {
      throw Exception('Could not launch ${widget.article.url}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _readNews,
      child: Skeletonizer(
        effect: ShimmerEffect(baseColor: mutedColor),
        enableSwitchAnimation: true,
        enabled: widget.isLoading,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(),
            const SizedBox(width: 8), // Space between image and text
            Expanded(child: _buildArticleText()),
          ],
        ),
      ),
    );
  }

  // Extracted image building logic to its own method
  Widget _buildImage() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: mutedColor
            .withOpacity(buttonOpacity), // Placeholder color in case of loading
        image: widget.isLoading
            ? null
            : DecorationImage(
                image: NetworkImage(widget.article.imageUrl),
                fit: BoxFit.fill,
              ),
      ),
    );
  }

  // Extracted the text (source, date, headline) into a separate method
  Widget _buildArticleText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSourceAndDate(),
        const SizedBox(height: 3.5),
        _buildHeadline(),
      ],
    );
  }

  // Build source and date row
  Widget _buildSourceAndDate() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildTextWidget(
          widget.article.source,
          fontSize: smallText,
        ),
        buildTextWidget(
          formatDate(widget.article.dateTime),
          fontSize: smallText,
        ),
      ],
    );
  }

  // Make The Source and Date into one widget
  Widget buildTextWidget(String text,
      {FontWeight fontWeight = FontWeight.w400,
      double fontSize = 12,
      Color color = Colors.white,
      double opacity = 0.7}) {
    return Text(
      text.toUpperCase(),
      style: GoogleFonts.rubik(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color.withOpacity(opacity),
      ),
    );
  }

  // Build the headline text
  Widget _buildHeadline() {
    return Text(
      widget.article.headline,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: subHeadingText - 2,
        color: Colors.white,
      ),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }
}
