import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/category/tab_widget.dart';
import 'package:news_app/model/category.dart';
import 'package:news_app/model/category_details_view_model.dart';
import 'package:news_app/theme/my_theme.dart';
import 'package:provider/provider.dart';

class CategoryDetails extends StatefulWidget {
  final CategoryDM? category;

  final Function onTap;

  const CategoryDetails(
      {super.key, required this.category, required this.onTap});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.getResponse(widget.category?.id ?? "");
  }

  CategoryDetailsViewModel viewModel = CategoryDetailsViewModel();

  @override
  Widget build(BuildContext context) {
    var _appLocalization = AppLocalizations.of(context)!;

    return ChangeNotifierProvider(
        create: (context) => viewModel,
        child: Consumer<CategoryDetailsViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.errorMessage != null) {
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
                        viewModel.getResponse(widget.category?.id ?? "");
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
            } else {
              if (viewModel.sourceList == null) {
                return Center(
                  child: CircularProgressIndicator(
                      color: MyTheme.primaryLightColor),
                );
              } else {
                return TabWidget(
                  sourcesList: viewModel.sourceList!,
                  onTap: widget.onTap,
                );
              }
            }
          },
        ));
  }
}
