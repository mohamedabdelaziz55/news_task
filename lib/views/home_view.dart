import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../models/model.dart';
import '../services/news_service.dart';
import '../widgets/category_card.dart';
import '../widgets/icons_appbar.dart';
import '../widgets/list_view_category.dart';
import '../widgets/news_card.dart';

class HomeView extends StatefulWidget {
  static String id = "HomeView";
  final String category;

  const HomeView({super.key, this.category = "technology"});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Articles> newsList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    NewsService newsService = NewsService(Dio());
    List<Articles> articles =
    await newsService.getNewsByCategory(widget.category);

    setState(() {
      newsList = articles;
      isLoading = false;
    });
  }

  Future<void> _onRefresh() async {
    setState(() {
      isLoading = true;
    });
    await fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: const MenuIcon(),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("News", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("App"),
          ],
        ),
        actions: const [IconsSearch(icon: Icons.mic_none)],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
        onRefresh: _onRefresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  height: 320,
                  child: CategoryListView()),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${widget.category[0].toUpperCase()}${widget.category.substring(1)} News",
                      style: TextStyle(
                        color: const Color(0xff111E29).withOpacity(0.5),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_circle_right_outlined,
                        size: 18,
                        color:
                        const Color(0xff111E29).withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: newsList.length,
                itemBuilder: (context, index) {
                  return NewsCard(
                    onDelete: () {},
                    article: newsList[index],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
