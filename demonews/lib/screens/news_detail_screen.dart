import 'package:demonews/models/article.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailScreen extends StatefulWidget {
  final ArticleModel article;

  const NewsDetailScreen({Key key, this.article}) : super(key: key);

  @override
  _NewsDetailScreenState createState() => _NewsDetailScreenState(article);
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  final ArticleModel article;

  _NewsDetailScreenState(this.article);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GestureDetector(
        onTap: () {
          launch(article.url);
        },
        child: Container(
          height: 48.0,
          width: MediaQuery.of(context).size.width,
          color: Colors.orange,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
            Text("Read More",style: TextStyle(
              color: Colors.white,
              fontSize: 15.0,
            ),)
          ],),
        ),
      ),
      appBar: AppBar(
        elevation: 8.0,
        backgroundColor: Colors.deepOrangeAccent,
        title: Text(
          article.title,
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/images/pl1.png',
              image: article.img,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  article.date.substring(0, 10),
                  style: TextStyle(
                      color: Colors.deepOrangeAccent,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  article.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  article.description,
                  style: TextStyle(
                    // fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.blueGrey,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
