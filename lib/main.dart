import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(ShrinkTopListPage());
}

class ShrinkTopListPage extends StatefulWidget {
  @override
  _ShrinkTopListPageState createState() => _ShrinkTopListPageState();
}

class _ShrinkTopListPageState extends State<ShrinkTopListPage> {
  final scrollController = ScrollController();

  void onListen() {
    print(scrollController.offset);

    setState(() {});
  }

  @override
  void initState() {
    scrollController.addListener(onListen);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.removeListener(onListen);
    scrollController.dispose();
    super.dispose();
  }

  List _colors = [
    Colors.orange,
    Colors.purple,
    Colors.red,
  ];

  double _cardHeight = 150.0;
  var _cardMargin = EdgeInsets.only(bottom: 30.0);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: CustomScrollView(
          controller: scrollController,
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final double itemPositionOffset = index * _cardHeight;
                  final double difference =
                      scrollController.offset - itemPositionOffset;

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Card(
                      child: SizedBox(height: _cardHeight),
                      margin: _cardMargin,
                      color:
                          _colors.elementAt(Random().nextInt(_colors.length)),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
