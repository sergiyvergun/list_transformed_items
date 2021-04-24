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
    Colors.green,
  ];

  double _itemSize = 150.0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: CustomScrollView(
          controller: scrollController,
          slivers: <Widget>[
            Placeholder(),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final double itemPositionOffset = index * _itemSize / 2;
                  final double difference =
                      scrollController.offset - itemPositionOffset;

                  final double percent = 1 - (difference / (_itemSize / 2));

                  double opacity = percent;
                  double scale = percent;

                  if (opacity > 1.0) opacity = 1.0;
                  if (opacity < 0.0) opacity = 0.0;

                  if (percent > 1.0) scale = 1.0;

                  return Align(
                    heightFactor: 0.5,
                    child: Opacity(
                      opacity: opacity,
                      child: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()..scale(scale, 1.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          child: Row(
                            children: [
                              SizedBox(height: _itemSize),
                            ],
                          ),
                          color: _colors.elementAt(index % _colors.length),
                        ),
                      ),
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
