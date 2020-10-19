import 'package:demonews/bloc/get_source_news.dart';
import 'package:demonews/bloc/get_sourcesbloc.dart';
import 'package:demonews/elements/error_element.dart';
import 'package:demonews/elements/loader_element.dart';
import 'package:demonews/models/source_response.dart';
import 'package:demonews/models/sources.dart';
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
    //tommarow will continue
  }
}
