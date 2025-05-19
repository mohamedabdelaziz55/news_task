import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/bookMarks_cubit/book_marks_cubit.dart';
import '../cubits/category_cubit/category_cubit.dart';
import '../cubits/category_cubit/category_state.dart';
import '../storage_helper.dart';
import '../widgets/news_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CategoryView extends StatefulWidget {
  final String category;
  static String id = "CategoryView";

  CategoryView({super.key, this.category = "technology"});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  int selectedIndex = 0;

  String getTranslatedCategoryName(BuildContext context, String category) {
    final loc = AppLocalizations.of(context)!;

    switch (category.toLowerCase()) {
      case 'technology':
        return loc.technology;
      case 'sports':
        return loc.sports;
      case 'business':
        return loc.business;
      case 'health':
        return loc.health;
      case 'entertainment':
        return loc.entertainment;
      case 'science':
        return loc.science;
      case 'general':
        return loc.general;
      default:
        return category;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;

    final localizedCategoryName = getTranslatedCategoryName(context, widget.category);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => NewsCategoryCubit()..fetchCategoryNews(widget.category),
        ),
        BlocProvider(
          create: (_) => BookmarksCubit(DatabaseHelper.instance)..loadBookmarks(),
        )
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "$localizedCategoryName ${AppLocalizations.of(context)!.news}",
            style: TextStyle(fontSize: w * 0.05),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<NewsCategoryCubit, NewsCategoryState>(
          builder: (context, state) {
            if (state is NewsCategoryLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is NewsCategorySuccess) {
              return RefreshIndicator(
                onRefresh: () => context.read<NewsCategoryCubit>().fetchCategoryNews(widget.category),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: w * 0.04, vertical: h * 0.01),
                  child: ListView.builder(
                    itemCount: state.articles.length,
                    itemBuilder: (context, index) {
                      final article = state.articles[index];
                      return Padding(
                        padding: EdgeInsets.only(bottom: h * 0.02),
                        child: NewsCard(
                          article: article,
                          icon: Icons.bookmark_border,
                          logic: () async {
                            setState(() {
                              selectedIndex = 1;
                            });

                            final articleMap = {
                              'title': article.title ?? '',
                              'description': article.description ?? '',
                              'url': article.url ?? '',
                              'urlToImage': article.urlToImage ?? '',
                            };

                            try {
                              await context.read<BookmarksCubit>().addArticle(articleMap);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    AppLocalizations.of(context)!.articleBookmarked,
                                    style: TextStyle(fontSize: w * 0.04),
                                  ),
                                ),
                              );
                            } catch (_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    AppLocalizations.of(context)!.bookmarkFail,
                                    style: TextStyle(fontSize: w * 0.04),
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      );
                    },
                  ),
                ),
              );
            } else if (state is NewsCategoryError) {
              return Center(
                child: Text(
                  state.message,
                  style: TextStyle(fontSize: w * 0.045),
                  textAlign: TextAlign.center,
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
