import 'package:demonews/bloc/get_sourcesbloc.dart';
import 'package:demonews/elements/error_element.dart';
import 'package:demonews/elements/loader_element.dart';
import 'package:demonews/models/source_response.dart';
import 'package:demonews/models/sources.dart';
import 'package:demonews/screens/sources_screen.dart';
import 'package:flutter/material.dart';

class TopChannels extends StatefulWidget {
  @override
  _TopChannelsState createState() => _TopChannelsState();
}

class _TopChannelsState extends State<TopChannels> {
  @override
  void initState() {
    super.initState();
    getSourcesBloc..getSourdes();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SourceResponce>(
      stream: getSourcesBloc.subject.stream,
      builder: (context, AsyncSnapshot<SourceResponce> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return buildErrorWidget(snapshot.data.error);
          }
          return _buildTopChannels(snapshot.data);
        } else if (snapshot.hasError) {
          return buildErrorWidget(snapshot.error);
        } else {
          return buildLoadinWidget();
        }
      },
    );
  }

  Widget _buildTopChannels(SourceResponce data) {
    List<SourceModel> sources = data.sources;
    if (sources.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Text('No Sources'),
          ],
        ),
      );
    } else {
      return Container(
        height: 115.0,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: sources.length,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.only(
                  top: 10.0,
                ),
                width: 80.0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SourcesScreen(sources:sources[index]),),);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Hero(
                        tag: sources[index].id,
                        child: Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 2.0,
                                spreadRadius: 1.0,
                                offset: Offset(1.0, 1.0),
                              ),
                            ],
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/images/pl1.png'
                                  // 'assets/images/${sources[index].id}.png'
                                  ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        sources[index].name,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            height: 1.4,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 10.0),
                      ),
                      SizedBox(
                        height: 3.0,
                      ),
                      Text(
                        sources[index].category,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 9.0,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      );
    }
  }
}
