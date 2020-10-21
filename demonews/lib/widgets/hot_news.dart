import 'package:demonews/bloc/get_hot_news.dart';
import 'package:demonews/elements/error_element.dart';
import 'package:demonews/elements/loader_element.dart';
import 'package:demonews/models/article.dart';
import 'package:demonews/models/article_response.dart';
import 'package:demonews/screens/news_detail_screen.dart';
import 'package:flutter/material.dart';
import '../styles/theam.dart' as Style;
import 'package:timeago/timeago.dart' as timeago;

class HotNews extends StatefulWidget {
  @override
  _HotNewsState createState() => _HotNewsState();
}

class _HotNewsState extends State<HotNews> {
  @override
  void initState() {
    super.initState();
    gethotNewBloc..getHotNews();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ArticleResponce>(
      stream: gethotNewBloc.subject.stream,
      builder: (context, AsyncSnapshot<ArticleResponce> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return buildErrorWidget(snapshot.data.error);
          }
          return _buildHotNews(snapshot.data);
        } else if (snapshot.hasError) {
          return buildErrorWidget(snapshot.error);
        } else {
          return buildLoadinWidget();
        }
      },
    );
  }

  Widget _buildHotNews(ArticleResponce data) {
    List<ArticleModel> article = data.articles;
    // if (article.length == 0) {
    //   return Container(

    //     width: MediaQuery.of(context).size.width,
    //     child: Column(
    //       children: [
    //         Text('No Articles'),
    //       ],
    //     ),
    //   );
    // } else {
      return Container(
        height: article.length/2 * 210.0,
        padding: EdgeInsets.all(5.0),
        child: GridView.builder(
          itemCount: article.length,
          physics: NeverScrollableScrollPhysics(),
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                childAspectRatio: 0.85),
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                  top: 10.0,
                ),
                child: GestureDetector(
                  onTap: () {
                     Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsDetailScreen(article: article[index]),
                ),
              );
                  },
                  child: Container(
                    width: 220.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5.0,
                          spreadRadius: 1.0,
                          offset: Offset(1.0, 1.0),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5.0),
                                topRight: Radius.circular(5.0),
                              ),
                              image: DecorationImage(
                                image: article[index].img == null
                                    ? AssetImage('assets/images/pl1.png')
                                    : NetworkImage(article[index].img),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            left: 10.0,
                            right: 10.0,
                            top: 15.0,
                            bottom: 15.0,
                          ),
                          child: Text(
                            article[index].title,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: TextStyle(
                              height: 1.3,
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                left: 10.0,
                                right: 10.0,
                              ),
                              width: 180.0,
                              height: 1.0,
                              color: Colors.black,
                            ),
                            Container(
                              width: 30.0,
                              height: 3.0,
                              color: Style.Colors.mainColor,
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                article[index].source.name,
                                style: TextStyle(
                                  color: Style.Colors.mainColor,
                                  fontSize: 9.0,
                                ),
                              ),
                              Text(
                                timeAgo(
                                  DateTime.parse(article[index].date),
                                ),
                                style: TextStyle(
                                  color:Colors.black45,
                                  fontSize: 9.0,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
      );
    }
  }

  String timeAgo(DateTime date) {
    return timeago.format(date, allowFromNow: true, locale: 'en');
  }

