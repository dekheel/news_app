import 'package:flutter/material.dart';
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/category/tab_widget.dart';
import 'package:news_app/model/NewsResponse.dart';
import 'package:news_app/model/category.dart';
import 'package:news_app/model/sourceResponse.dart';
import 'package:news_app/theme/my_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CategoryDetails extends StatefulWidget {
  CategoryDM? category;

  Function onTap;

  CategoryDetails({super.key, required this.category, required this.onTap});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  Widget build(BuildContext context) {
    var _appLocalization = AppLocalizations.of(context)!;

    return FutureBuilder<SourceResponse?>(
      future: ApiManager.getResponse(widget.category?.id ?? ""),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(color: MyTheme.primaryLightColor),
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
                    ApiManager.getResponse(widget.category?.id ?? "");
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
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    snapshot.data!.message ?? "",
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.justify,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      ApiManager.getResponse(widget.category?.id ?? "");
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
            ),
          );
        }

        var sourcesList = snapshot.data?.sources ?? [];
        return TabWidget(
          sourcesList: sourcesList,
          onTap: widget.onTap,
        );
      },
    );
  }
}
