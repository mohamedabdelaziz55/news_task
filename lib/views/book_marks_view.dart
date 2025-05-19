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
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(loc.categories,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 250,
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
                                context
                                    .read<BookmarksCubit>()
                                    .deleteCategory(cat['category']);
                              },
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(loc.latestBookmarks,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 16),
                      if (articles.isEmpty)
                        Center(child: Text(loc.noBookmarks))
                      else
                        ...articles.map(
                              (article) => Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: NewsCard(
                              article: Articles.fromMap(article),
                              logic: () {
                                context
                                    .read<BookmarksCubit>()
                                    .deleteArticle(article['url']);
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
