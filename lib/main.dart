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
  ScrollController scrollController;

  void onListen() {
    setState(() {});
  }

  @override
  void initState() {
    scrollController = ScrollController();
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
      home: SafeArea(
        child: Scaffold(
          body: CustomScrollView(
            controller: scrollController,
            slivers: <Widget>[
              SliverToBoxAdapter(
                  child: Placeholder(
                fallbackHeight: 100,
              )),
              SliverPersistentHeader(
                pinned: true,
                delegate: _CustomHeaderDelegate(),
              ),
              SliverAppBar(
                title: Text(
                  'App bar',
                  style: TextStyle(
                    color: Colors.blueGrey[900],
                  ),
                ),
                pinned: true,
                backgroundColor: Colors.transparent,
                elevation: 0.0,
              ),
              SliverToBoxAdapter(child: SizedBox(height: 50)),
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
      ),
    );
  }
}

class _CustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container();
  }

  @override
  double get maxExtent => 100;

  @override
  double get minExtent => 100;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
