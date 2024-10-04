// This file holds configuration information about the application
// All apps configurations goes here like application name, colors, screen sizes

import 'package:flutter/material.dart';

const brandName = "Blott Mobile";

// 'https://finnhub.io/docs/api/market-news';
String apiUrl = "https://finnhub.io/api/v1/news?category=general&token=$apiKey";

String apiKey = 'crals9pr01qhk4bqotb0crals9pr01qhk4bqotbg';

// Application Color
Color bgColor = const Color(0xffF9F9F9);
Color buttonTextBlueColor = const Color(0xff007AFF);
Color primaryColor = const Color(0xff523AE4);
Color tertiaryColor = primaryColor.withOpacity(.8);
Color whiteColor = const Color(0xffFAFAFA);
Color greyColor = const Color(0xff737373);
Color mutedColor = const Color(0xffD4D4D4);
Color lineColor = const Color(0xfff2f2f2cc);

// Spaces and Gaps
double extraSmallWhiteSpace = 15.0;
double smallWhiteSpace = 25.0;
double whiteSpace = 30.0;
double largeWhiteSpace = 37.5;

double blurRadius = 9.0;
double spreadRadius = 2.0;
double shadowOpacity = 0.1;
double shadowOpacityMd = 0.3;
double buttonOpacity = 0.5;

double headingText = 30.0;
double subHeadingText = 20.0;
double paragraphText = 16.0;
double smallText = 13.0;
double extraSmallText = 10.0;

// Border Radius
double roundedSm = 6.0;
double roundedMd = 8.0;
double roundedLg = 16.0;
double roundedFull = 100.0;

// Animations
double animationDuration = 500; // milliseconds
int toastNotificationDuration = 15; // seconds
