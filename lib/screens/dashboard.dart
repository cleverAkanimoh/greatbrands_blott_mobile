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
  final dio = Dio();
  String firstName = "";

// uses stream builder so they'll be no need for a refresh
  Stream<List<NewsArticle>> getNewsArticlesStream() async* {
    try {
      final response = await dio.get(apiUrl);
      if (response.statusCode == 200) {
        List<dynamic> jsonData = response.data; // dio auto-decodes the response

        final fetchedNews =
            jsonData.map((data) => NewsArticle.fromJson(data)).toList();

        yield fetchedNews; // Emit the list of fetched articles
      } else {
        throw Exception('Failed to load news articles');
      }
    } catch (e) {
      debugPrint("Error fetching news articles");
      rethrow;
    }
  }

  void getUserInfo() async {
    String userFirstName = await User.getFirstName();
    setState(() => firstName = userFirstName);
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
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
                      return ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemCount: 20, // Placeholder skeleton items
                        separatorBuilder: (context, index) =>
                            SizedBox(height: smallWhiteSpace),
                        itemBuilder: (context, index) {
                          return News(
                            article: NewsArticle(
                                category: "category",
                                dateTime: DateTime.now(),
                                headline:
                                    "Undefined name 'summary'. Try correcting the name to one that is defined, or defining the name.",
                                id: 4,
                                imageUrl: "",
                                related: "",
                                source: "CleverInc",
                                summary: "",
                                url: ""),
                            isLoading: true,
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Text(
                        "Something went wrong. Please try again later.",
                        style: GoogleFonts.rubik(color: whiteColor),
                      );
                    } else if (snapshot.hasData) {
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
