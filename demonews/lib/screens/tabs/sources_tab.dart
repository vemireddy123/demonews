import 'package:demonews/bloc/get_sourcesbloc.dart';
import 'package:flutter/material.dart';

class SourcesTab extends StatefulWidget {
  @override
  _SourcesTabState createState() => _SourcesTabState();
}

class _SourcesTabState extends State<SourcesTab> {
  @override
  void initState() {
    super.initState();
    getSourcesBloc..getSourdes();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
