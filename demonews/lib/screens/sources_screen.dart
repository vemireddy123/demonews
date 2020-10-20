import 'package:demonews/bloc/get_source_news.dart';
import 'package:demonews/elements/error_element.dart';
import 'package:demonews/elements/loader_element.dart';
import 'package:demonews/models/article.dart';
import 'package:demonews/models/article_response.dart';
import 'package:demonews/models/sources.dart';
import 'package:flutter/material.dart';
import '../styles/theam.dart' as Style;
import 'package:timeago/timeago.dart' as timeago;

class SourcesScreen extends StatefulWidget {
  final SourceModel sources;

  const SourcesScreen({Key key, this.sources}) : super(key: key);

  @override
  _SourcesScreenState createState() => _SourcesScreenState(sources);
}

class _SourcesScreenState extends State<SourcesScreen> {
  final SourceModel sources;

  _SourcesScreenState(this.sources);
  @override
  void initState() {
    super.initState();
    getSourceNewsBloc..getSourceNews(sources.id);
  }

  @override
  void dispose() {
    super.dispose();
    getSourceNewsBloc..drainStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: AppBar(
            title: Text(""),
          ),
          preferredSize: Size.fromHeight(40.0)),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
              left: 15.0,
              right: 15.0,
              bottom: 15.0,
            ),
            color: Style.Colors.mainColor,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Hero(
                  tag: sources.id,
                  child: SizedBox(
                    height: 80.0,
                    width: 80.0,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2.0,
                          color: Colors.white,
                        ),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage("assets/images/${sources.id}.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  sources.name,
                  style: TextStyle(
                    color: Colors.lightBlueAccent,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  sources.description,
                  style: TextStyle(
                    color: Colors.lightBlueAccent,
                    fontSize: 12.0,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<ArticleResponce>(
              stream: getSourceNewsBloc.subject.stream,
              builder: (context, AsyncSnapshot<ArticleResponce> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.error != null &&
                      snapshot.data.error.length > 0) {
                    return buildErrorWidget(snapshot.data.error);
                  }
                  return _buildSourceNews(snapshot.data);
                } else if (snapshot.hasError) {
                  return buildErrorWidget(snapshot.error);
                } else {
                  return buildLoadinWidget();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSourceNews(ArticleResponce data) {
    List<ArticleModel> articles = data.articles;
    if (articles.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("No Aricles"),
          ],
        ),
      );
    } else {
      return ListView.builder(
          itemCount: articles.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  color: Colors.white,
                ),
                height: 150.0,
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.0),
                      width: MediaQuery.of(context).size.width * 3 / 5,
                      child: Column(
                        children: [
                          Text(
                            articles[index].title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.lightBlueAccent,
                              fontSize: 14.0,
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Row(
                                children: [
                                  Text(
                                    timeAgo(
                                      DateTime.parse(articles[index].date),
                                    ),
                                    style: TextStyle(
                                      color: Colors.lightBlueAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10.0,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        right: 10.0,
                      ),
                      width: MediaQuery.of(context).size.width * 2 / 5,
                      height: 130.0,
                      child: FadeInImage.assetNetwork(placeholder: 'assets/images/pl1.png', image: articles[index].img,fit: BoxFit.fitHeight,
                      width: double.maxFinite,
                      height: MediaQuery.of(context).size.height * 1 / 3,
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
    }
  }

  String timeAgo(DateTime date) {
    return timeago.format(date, allowFromNow: true, locale: 'en');
  }
}
