import 'package:demonews/bloc/bottom_navbar.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import '../styles/theam.dart' as Style;

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  BottomNavBarBloc _bottonNavBarBloc;

  @override
  void initState() {
    super.initState();
    _bottonNavBarBloc = BottomNavBarBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        child: AppBar(
          backgroundColor: Style.Colors.mainColor,
          title: Text(
            'NewsApp',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        preferredSize: Size.fromHeight(50.0),
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: _bottonNavBarBloc.itemStream,
          initialData: _bottonNavBarBloc.defaultItem,
          // ignore: missing_return
          builder: (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
            switch (snapshot.data) {
              case NavBarItem.HOME:
                return Container();
              case NavBarItem.SOURCE:
                return Container();
              case NavBarItem.SEARCH:
                return Container();
            }
          },
        ),
      ),
      bottomNavigationBar: StreamBuilder(
        stream: _bottonNavBarBloc.itemStream,
        initialData: _bottonNavBarBloc.defaultItem,
        builder: (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[100],
                    spreadRadius: 0,
                    blurRadius: 10.0,
                  ),
                ]),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              child: BottomNavigationBar(backgroundColor: Colors.white,
              iconSize: 20.0,
              unselectedItemColor: Style.Colors.gry,
              unselectedFontSize: 9.5,
              selectedFontSize: 9.5,
              type: BottomNavigationBarType.fixed,
              fixedColor: Style.Colors.mainColor,
              currentIndex: snapshot.data.index,
              onTap: _bottonNavBarBloc.pickItem,
              items: [
                BottomNavigationBarItem(
                  title: Padding(padding: EdgeInsets.only(top: 5.0),
                  child: Text('Home'),),
                  icon: Icon(EvaIcons.homeOutline),)
              ],
              ),
            ),
          );
        },
      ),
    );
  }
}
