// This file holds configuration information about the application
// All apps configurations goes here like application name, colors, screen sizes

import 'package:flutter/material.dart';

const brandName = "Blott Mobile";

// 'https://finnhub.io/docs/api/market-news';
const apiUrl = "https://finnhub.io/api/v1/news?category=general&token=$apiKey";

const apiKey = 'crals9pr01qhk4bqotb0crals9pr01qhk4bqotbg';

// Application Color
Color bgColor = const Color(0xffF9F9F9);
Color buttonTextBlueColor = const Color(0xff007AFF);
Color primaryColor = const Color(0xff523AE4);
Color tertiaryColor = primaryColor.withOpacity(.8);
Color whiteColor = const Color(0xffFAFAFA);
Color greyColor = const Color(0xff737373);
Color mutedColor = const Color(0xffD4D4D4);
Color lineColor = const Color(0xF1F2F2CC);

// Spaces and Gaps
const extraSmallWhiteSpace = 15.0;
const smallWhiteSpace = 25.0;
const whiteSpace = 30.0;
const largeWhiteSpace = 37.5;

const blurRadius = 9.0;
const spreadRadius = 2.0;
const shadowOpacity = 0.1;
const shadowOpacityMd = 0.3;
const buttonOpacity = 0.5;

const headingText = 30.0;
const subHeadingText = 20.0;
const paragraphText = 16.0;
const smallText = 13.0;
const extraSmallText = 10.0;

// Border Radius
const roundedSm = 6.0;
const roundedMd = 8.0;
const roundedLg = 16.0;
const roundedFull = 100.0;

// Animations
const animationDuration = 500; // milliseconds
const toastNotificationDuration = 15; // seconds
