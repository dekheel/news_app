import 'package:flutter/material.dart';
import 'package:news_app/category/tab_item.dart';
import 'package:news_app/model/sourceResponse.dart';
import 'package:news_app/news/news_widget.dart';

import '../model/NewsResponse.dart';

class TabWidget extends StatefulWidget {
  List<Source> sourcesList;

  Function onTap;

  TabWidget({required this.sourcesList, super.key, required this.onTap});

  @override
  State<TabWidget> createState() => _TabWidgetState();
}

class _TabWidgetState extends State<TabWidget> {
  int selectedindex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: widget.sourcesList.length,
        child: Column(
          children: [
            TabBar(
                onTap: (index) {
                  selectedindex = index;
                  setState(() {});
                },
                indicatorColor: Colors.transparent,
                isScrollable: true,
                tabs: widget.sourcesList.map((source) {
                  return TabItem(
                      source: source,
                      isSelected:
                          selectedindex == widget.sourcesList.indexOf(source));
                }).toList()),
            Expanded(
                child: NewsWidget(
                    source: widget.sourcesList[selectedindex],
                    onTap: widget.onTap))
          ],
        ));
  }
}
