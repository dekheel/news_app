import 'package:flutter/material.dart';
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/model/NewsResponse.dart';
import 'package:news_app/model/sourceResponse.dart';
import 'package:news_app/news/news_item.dart';
import 'package:news_app/theme/my_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewsWidget extends StatefulWidget {
  Source source;
  List<News> news = []; // Initialize with an empty list
  Function onTap;

  NewsWidget({required this.source, super.key, required this.onTap}) {
    news = [];
  }

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  ScrollController listController = ScrollController();

  int currentPage = 1;
  bool noDataToFetch = false;

  @override
  void initState() {
    // TODO: implement initState
    widget.news.clear();

    listController.addListener(() {
      if (listController.position.maxScrollExtent == listController.offset) {
        currentPage = currentPage + 1;

        addNewsToList();
      }
    });
    super.initState();
  }

  Future<void> addNewsToList() async {
    var newsResponse = await ApiManager.getNewsBySourceId(
        sourceId: widget.source.id ?? "", page: "$currentPage");
    newsResponse.news?.forEach((element) {
      widget.news.add(element);
    });
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    listController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _appLocalization = AppLocalizations.of(context)!;

    return widget.news.isEmpty
        ? FutureBuilder(
            future: ApiManager.getNewsBySourceId(
              sourceId: widget.source.id ?? "",
              page: "$currentPage",
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                      color: MyTheme.primaryLightColor),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _appLocalization.something_went_wrong,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          ApiManager.getNewsBySourceId(
                            sourceId: widget.source.id ?? "",
                            page: "$currentPage",
                          );
                          setState(() {});
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor),
                        child: Text(
                          _appLocalization.try_again,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      )
                    ],
                  ),
                );
              } else if (snapshot.data?.status != "ok") {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        snapshot.data!.message!,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          ApiManager.getNewsBySourceId(
                            sourceId: widget.source.id ?? "",
                            page: "$currentPage",
                          );
                          setState(() {});
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor),
                        child: Text(
                          _appLocalization.try_again,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      )
                    ],
                  ),
                );
              }

              snapshot.data?.news?.forEach((element) {
                widget.news.add(element);
              });

              return widget.news.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _appLocalization.no_news,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              ApiManager.getNewsBySourceId(
                                sourceId: widget.source.id ?? "",
                                page: "$currentPage",
                              );
                              setState(() {});
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).primaryColor),
                            child: Text(
                              _appLocalization.try_again,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          )
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.only(bottom: 10),
                      controller: listController,
                      itemBuilder: (context, index) {
                        if (index < widget.news.length) {
                          return NewsItem(
                            newObject: widget.news[index],
                            onTap: widget.onTap,
                            onSearchTap: () {},
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(
                                color: MyTheme.primaryLightColor),
                          );
                        }
                      },
                      itemCount: widget.news.length + 1,
                    );
            },
          )
        : ListView.builder(
            padding: const EdgeInsets.only(bottom: 10),
            controller: listController,
            itemBuilder: (context, index) {
              if (index < widget.news.length) {
                return NewsItem(
                  newObject: widget.news[index],
                  onTap: widget.onTap,
                  onSearchTap: () {},
                );
              } else {
                return Center(
                  child: noDataToFetch
                      ? Text(
                          _appLocalization.no_data_to_fetch,
                          style: Theme.of(context).textTheme.titleMedium,
                        )
                      : CircularProgressIndicator(
                          color: MyTheme.primaryLightColor),
                );
              }
            },
            itemCount: widget.news.length + 1,
          );
  }
}
