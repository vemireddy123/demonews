import 'package:demonews/widgets/headerline_slider.dart';
import 'package:demonews/widgets/hot_news.dart';
import 'package:demonews/widgets/top_channels.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      // scrollDirection: Axis.vertical,
      children: [
        HeaderlineSliderWidget(),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            'Top channels',
            style: TextStyle(
              color: Colors.black,
              fontSize: 17.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        TopChannels(),
          Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            'Hot News',
            style: TextStyle(
              color: Colors.black,
              fontSize: 17.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        HotNews(),
      ],
    );
  }
}
