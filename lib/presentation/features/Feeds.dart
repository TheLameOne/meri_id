import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../model/News.dart';
import '../../services/widgets/CustomText.dart';
import '../../utils/global.dart';
import '../../utils/strings.dart';
import '../../utils/styles.dart';
import '../custom/NewsCard.dart';

class Feeds extends StatefulWidget {
  static const String routeNamed = 'Feeds';
  @override
  State<Feeds> createState() => _FeedsState();
}

class _FeedsState extends State<Feeds> {
  bool isLoading = true;
  bool _language = true;
  List<News> news = <News>[];
  @override
  void initState() {
    super.initState();
    _parent();
  }

  _parent() async {
    await _languageFunction();
    await _getNews();
    await _loadingOff();
  }

  _languageFunction() async {
    bool val = await checkLanguage();
    _language = val;
  }

  _getNews() async {
    const String url =
        "https://newsapi.org/v2/top-headlines?country=in&q=government&apiKey=b959933666884935be61f74caa1c9a9b";
    Response res = await get(Uri.parse(url));
    print(res.body);
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      if (body["status"] == 'ok') {
        for (int i = 0; i < body['articles'].length; i++) {
          news.add(News(
              title: body['articles'][i]['title'] ?? "",
              content: body['articles'][i]['content'] ?? "",
              description: body['articles'][i]['description'] ?? "",
              publishedAt: body['articles'][i]['publishedAt'] == null
                  ? ""
                  : body['articles'][i]['publishedAt'].toString(),
              url: body['articles'][i]['url'] ?? "",
              urlToImage: body['articles'][i]['urlToImage'] ??
                  "https://image.scoopwhoop.com/q30/s3.scoopwhoop.com/anj2/613ef82b8a373a1f92941ea7/4ec60915-2c14-4f0f-b92f-709663704778.jpg"));
        }
      }
    }
  }

  _loadingOff() {
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Styles.backgroundColor,
        appBar: AppBar(
          actions: [],
          backgroundColor: Styles.backgroundColor,
          foregroundColor: Styles.blackColor,
          elevation: 0,
        ),
        body: (isLoading)
            ? const Center(
                child: CircularProgressIndicator(color: Styles.redColor),
              )
            : SingleChildScrollView(
                child: Container(
                  color: Styles.backgroundColor,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(bottom: 32, left: 32, right: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText.xLargeText(
                          (_language)
                              ? StringValues.newsFeed.english
                              : StringValues.newsFeed.hindi,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        for (int i = 0; i < news.length; i++)
                          NewsCard(
                            news: news[i],
                            ontap: () async {
                              if (await canLaunchUrl(Uri.parse(news[i].url))) {
                                await launchUrl(Uri.parse(news[i].url));
                              } else {}
                            },
                          )
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
