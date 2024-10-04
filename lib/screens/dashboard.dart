import 'package:greatbrands_blott_mobile/helpers/navigator_push.dart';
import 'package:greatbrands_blott_mobile/models/news_article.dart';
import 'package:dio/dio.dart';
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
  final Dio dio = Dio();
  String firstName = "";

  // Uses StreamBuilder so there's no need for manual refresh
  Stream<List<NewsArticle>> getNewsArticlesStream() async* {
    try {
      final response = await dio.get(apiUrl);
      if (response.statusCode == 200) {
        List<dynamic> jsonData = response.data; // Dio auto-decodes the JSON

        // Map the response data to the NewsArticle model
        final fetchedNews =
            jsonData.map((data) => NewsArticle.fromJson(data)).toList();
        yield fetchedNews; // Emit the list of fetched articles
      } else {
        throw Exception('Failed to load news articles');
      }
    } catch (e) {
      // Catch and log any errors
      debugPrint("Error fetching news articles: $e");
      rethrow;
    }
  }

  // Fetch user information asynchronously and handle potential errors
  void getUserInfo() async {
    try {
      String userFirstName = await User.getFirstName();
      setState(() {
        firstName = userFirstName;
      });
    } catch (e) {
      debugPrint("Error fetching user info: $e");
      // Default to "Guest" if fetching user info fails
      setState(() {
        firstName = "Guest";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getUserInfo(); // Fetch user info when the widget is initialized
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
              // Display the user's first name, with proper fallback
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
                child: StreamBuilder<List<NewsArticle>>(
                  stream: getNewsArticlesStream(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // Show a placeholder list while waiting for data
                      return ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemCount: 20, // Number of placeholder items
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
                      // Display an error message if there's an issue
                      return GestureDetector(
                        onTap: () =>
                            NavigatorPush.pushReplace(page: const Dashboard()),
                        child: Text(
                          "Something went wrong. Please try again later.",
                          style: GoogleFonts.rubik(color: whiteColor),
                        ),
                      );
                    } else if (snapshot.hasData) {
                      // Display the fetched news articles
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
                      // Show a message if no data is available
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
            ],
          ),
        ),
      ),
    );
  }
}
