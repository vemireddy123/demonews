import 'package:carousel_slider/carousel_slider.dart';
import 'package:demonews/bloc/get_top_newsbloc.dart';
import 'package:demonews/elements/error_element.dart';
import 'package:demonews/elements/loader_element.dart';
import 'package:demonews/models/article.dart';
import 'package:demonews/models/article_response.dart';
import 'package:demonews/screens/news_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class HeaderlineSliderWidget extends StatefulWidget {
  @override
  _HeaderlineSliderWidgetState createState() => _HeaderlineSliderWidgetState();
}

class _HeaderlineSliderWidgetState extends State<HeaderlineSliderWidget> {
  @override
  void initState() {
    getTopNewBloc..getTopNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ArticleResponce>(
      stream: getTopNewBloc.subject.stream,
      builder: (context, AsyncSnapshot<ArticleResponce> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return buildErrorWidget(snapshot.data.error);
          }
          return _buildHeadLineSlider(snapshot.data);
        } else if (snapshot.hasError) {
          return buildErrorWidget(snapshot.error);
        } else {
          return buildLoadinWidget();
        }
      },
    );
  }

  Widget _buildHeadLineSlider(ArticleResponce data) {
    List<ArticleModel> articles = data.articles;
    return Container(
      child: CarouselSlider(
        items: getExpencesSlider(articles),
        options: CarouselOptions(
          enlargeCenterPage: false,
          height: 200.0,
          viewportFraction: 0.9,
        ),
      ),
    );
  }

  getExpencesSlider(List<ArticleModel> article) {
    return article
        .map(
          (article) => GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsDetailScreen(article: article),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.only(
                left: 5.0,
                right: 5.0,
                top: 10.0,
                bottom: 10.0,
              ),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: article.img == null
                            ? AssetImage('assets/images/pl1.png')
                            : NetworkImage(article.img),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                        gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            stops: [
                              0.1,
                              0.9,
                            ],
                            colors: [
                              Colors.black.withOpacity(0.9),
                              Colors.white.withOpacity(0.0),
                            ])),
                  ),
                  Positioned(
                    bottom: 30.0,
                    child: Container(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      width: 250.0,
                      child: Column(
                        children: [
                          Text(
                            article.title,
                            style: TextStyle(
                              height: 1.5,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10.0,
                    left: 10.0,
                    child: Text(
                      article.source.name,
                      style: TextStyle(
                        fontSize: 9.0,
                        color: Colors.white24,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10.0,
                    right: 10.0,
                    child: Text(
                      timeAgo(
                        DateTime.parse(article.date),
                      ),
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 9.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
        .toList();
  }

  String timeAgo(DateTime date) {
    return timeago.format(date, allowFromNow: true, locale: 'en');
  }
}
