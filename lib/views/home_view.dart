import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../cubits/bookMarks_cubit/book_marks_cubit.dart';
import '../cubits/home_cubit/home_cubit.dart';
import '../widgets/icons_appbar.dart';
import '../widgets/list_view_category.dart';
import '../widgets/news_card.dart';
import 'category_view.dart';

class HomeView extends StatefulWidget {
  static String id = "HomeView";
  final String category;

  const HomeView({super.key, this.category = "technology"});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit()..fetchNews(widget.category),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          leading: const MenuIcon(),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                loc.news,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: w * 0.05,
                ),
              ),
              Text(
                loc.app,
                style: TextStyle(fontSize: w * 0.05),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: w * 0.02),
              child: const IconsSearch(icon: Icons.mic_none),
            ),
          ],
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HomeSuccess) {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<HomeCubit>().fetchNews(widget.category);
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: h * 0.38,
                        child:  CategoryListView(),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: w * 0.04,
                          vertical: h * 0.015,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${widget.category[0].toUpperCase()}${widget.category.substring(1)} ${loc.news}",
                              style: TextStyle(
                                color: const Color(0xff111E29).withAlpha(120),
                                fontSize: w * 0.04,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.pushNamed(context, CategoryView.id);
                              },
                              icon: Icon(
                                Icons.arrow_circle_right_outlined,
                                size: w * 0.05,
                                color: const Color(0xff111E29).withAlpha(120),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.articles.length,
                        itemBuilder: (context, index) {
                          final article = state.articles[index];

                          return NewsCard(
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
                                  SnackBar(content: Text(loc.articleBookmarked)),
                                );
                              } catch (_) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(loc.bookmarkFail)),
                                );
                              }
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is HomeError) {
              return Center(
                child: Text(
                  state.error,
                  style: TextStyle(fontSize: w * 0.045, color: Colors.red),
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
