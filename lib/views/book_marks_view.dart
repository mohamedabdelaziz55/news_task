import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../cubits/bookMarks_cubit/book_marks_cubit.dart';
import '../cubits/bookMarks_cubit/book_marks_state.dart';
import '../models/model.dart';
import '../storage_helper.dart';
import '../widgets/news_card.dart';
import '../widgets/category_card.dart';
import '../widgets/icons_appbar.dart';

class BookMarksView extends StatelessWidget {
  const BookMarksView({super.key});
  static String id = 'BookMarks';

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    final loc = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (_) => BookmarksCubit(DatabaseHelper.instance)..loadBookmarks(),
      child: BlocBuilder<BookmarksCubit, BookmarksState>(
        builder: (context, state) {
          if (state is BookmarksLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (state is BookmarksLoaded) {
            final articles = state.articles;
            final categories = state.categories;

            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                centerTitle: true,
                leading: const MenuIcon(),
                actions: const [IconsSearch(icon: Icons.search)],
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: w * 0.04, vertical: h * 0.02),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        loc.categories,
                        style: TextStyle(
                          fontSize: w * 0.05,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: h * 0.015),
                      SizedBox(
                        height: h * 0.3,
                        child: categories.isEmpty
                            ? Center(child: Text(loc.noCategories))
                            : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            final cat = categories[index];
                            return CategoryCard(
                              category: cat['category'],
                              imagePath: cat['imagePath'],
                              title: cat['title'],
                              onRemove: () {
                                context.read<BookmarksCubit>().deleteCategory(cat['category']);
                              },
                            );
                          },
                        ),
                      ),
                      SizedBox(height: h * 0.03),
                      Text(
                        loc.latestBookmarks,
                        style: TextStyle(
                          fontSize: w * 0.05,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: h * 0.02),
                      if (articles.isEmpty)
                        Center(child: Text(loc.noBookmarks))
                      else
                        ...articles.map(
                              (article) => Padding(
                            padding: EdgeInsets.only(bottom: h * 0.015),
                            child: NewsCard(
                              article: Articles.fromMap(article),
                              logic: () {
                                context.read<BookmarksCubit>().deleteArticle(article['url']);
                              },
                              icon: Icons.delete,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Scaffold(
              body: Center(child: Text(loc.somethingWrong)),
            );
          }
        },
      ),
    );
  }
}
