import 'package:greatbrands_blott_mobile/models/news_article.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import 'package:greatbrands_blott_mobile/app_config.dart';
import 'package:greatbrands_blott_mobile/helpers/user.dart';
import 'package:greatbrands_blott_mobile/widgets/news_article.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String firstName = "";

  // Convert Future to Stream for StreamBuilder
  Stream<List<NewsArticle>> getNewsArticlesStream() async* {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body);
        final fetchedNews =
            jsonData.map((data) => NewsArticle.fromJson(data)).toList();
        yield fetchedNews; // Emit fetched news
      } else {
        throw Exception('Failed to load news articles');
      }
    } catch (e) {
      debugPrint("Error fetching news articles: $e");
      rethrow;
    }
  }

  Future<void> _refreshNews() async {
    setState(() {}); // Triggers a refresh of the StreamBuilder
  }

  void getUserInfo() async {
    try {
      String userFirstName = await User.getFirstName();
      setState(() {
        firstName = userFirstName;
      });
    } catch (e) {
      debugPrint("Error fetching user info: $e");
      setState(() {
        firstName = "Guest";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(smallWhiteSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display user's first name
              Text(
                "Hey ${firstName.capitalize}",
                style: GoogleFonts.raleway(
                  color: whiteColor,
                  fontWeight: FontWeight.w900,
                  fontSize: 32,
                ),
              ),
              SizedBox(height: whiteSpace),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _refreshNews,
                  child: StreamBuilder<List<NewsArticle>>(
                    stream: getNewsArticlesStream(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // Show placeholders while loading
                        return ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemCount: 20,
                          separatorBuilder: (context, index) =>
                              SizedBox(height: smallWhiteSpace),
                          itemBuilder: (context, index) {
                            return News(
                              article: NewsArticle(
                                category: "Loading...",
                                dateTime: DateTime.now(),
                                headline:
                                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla facilisi. Vestibulum sed risus vel orci blandit malesuada.",
                                id: index,
                                imageUrl: "",
                                related: "",
                                source: "GreatBrands",
                                summary: "",
                                url: "",
                              ),
                              isLoading: true,
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        // Show error message with retry
                        return GestureDetector(
                          onTap: _refreshNews,
                          child: Text(
                            "Something went wrong. Please try again later.",
                            style: GoogleFonts.rubik(color: whiteColor),
                          ),
                        );
                      } else if (snapshot.hasData &&
                          snapshot.data!.isNotEmpty) {
                        // Show fetched news articles
                        List<NewsArticle> newsArticles = snapshot.data!;
                        return ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemCount: newsArticles.length,
                          separatorBuilder: (context, index) =>
                              SizedBox(height: smallWhiteSpace),
                          itemBuilder: (context, index) {
                            NewsArticle newsArticle = newsArticles[index];
                            return News(article: newsArticle);
                          },
                        );
                      } else {
                        // Show message if no data
                        return Center(
                          child: Text(
                            "No news articles available.",
                            style: TextStyle(color: whiteColor),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
