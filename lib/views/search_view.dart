import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/search_cubit/search_cubit.dart';
import '../cubits/search_cubit/search_state.dart';
import '../views/news_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchView extends StatefulWidget {
  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _searchController = TextEditingController();
  late final SearchCubit _searchCubit;

  @override
  void initState() {
    super.initState();
    _searchCubit = SearchCubit();
  }

  @override
  void dispose() {
    _searchCubit.close();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return BlocProvider.value(
      value: _searchCubit,
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(w * 0.035),
          child: Column(
            children: [
              SizedBox(height: h * 0.07),
              Container(
                height: h * 0.085,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(w * 0.1),
                  color: const Color(0xff141E28).withOpacity(.8),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: w * 0.045),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          onSubmitted: (query) {
                            _searchCubit.searchNews(query);
                          },
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: loc.searchHint,
                            hintStyle: TextStyle(color: Colors.white54, fontSize: w * 0.04),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _searchCubit.searchNews(_searchController.text);
                        },
                        child: Container(
                          height: w * 0.1,
                          width: w * 0.1,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(w * 0.1),
                          ),
                          child: Icon(Icons.search, size: w * 0.06),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: h * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    loc.searchResultsTitle,
                    style: TextStyle(fontSize: w * 0.06, fontWeight: FontWeight.bold),
                  ),
                  Icon(Icons.arrow_circle_right_outlined, size: w * 0.07),
                ],
              ),
              SizedBox(height: h * 0.025),
              Expanded(
                child: BlocBuilder<SearchCubit, SearchState>(
                  builder: (context, state) {
                    if (state is SearchLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is SearchLoaded) {
                      final articles = state.articles;
                      return articles.isEmpty
                          ? Center(child: Text(loc.searchNoResults, style: TextStyle(fontSize: w * 0.045)))
                          : ListView.builder(
                        itemCount: articles.length,
                        itemBuilder: (context, index) {
                          final article = articles[index];
                          return InkWell(
                            onTap: () {
                              if (article.url != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => NewsView(article: article),
                                  ),
                                );
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: h * 0.01),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(w * 0.03),
                                    child: Image.network(
                                      article.urlToImage ?? "https://www.souqfriday.com/src/images/no-image.png",
                                      width: w * 0.22,
                                      height: w * 0.22,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(width: w * 0.03),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          article.source?.name ?? loc.searchUnknownSource,
                                          style: TextStyle(
                                            fontSize: w * 0.03,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: h * 0.007),
                                        Text(
                                          article.title ?? loc.searchNoTitle,
                                          style: TextStyle(
                                            fontSize: w * 0.04,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else if (state is SearchError) {
                      return Center(
                        child: Text(state.message, style: TextStyle(fontSize: w * 0.045)),
                      );
                    }
                    return Container();
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
