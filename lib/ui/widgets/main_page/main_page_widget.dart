import 'package:flutter/material.dart';
import 'package:the_movie_db/domain/data_providers/session_data_provider.dart';
import 'package:the_movie_db/library/widgets/inherited/provider.dart';
import 'package:the_movie_db/ui/widgets/main_page/main_page_model.dart';
import 'package:the_movie_db/ui/widgets/movie_list/movie_list_model.dart';
import 'package:the_movie_db/ui/widgets/movie_list/movie_list_widget.dart';
import 'package:the_movie_db/ui/widgets/news/news_widget.dart';
import 'package:the_movie_db/ui/widgets/tv_show_list/tv_show_list.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedDestination = 0;
  final movieListModel = MovieListModel();

  void onSelectTab(int index) {
    if (_selectedDestination == index) return;
    setState(() {
      _selectedDestination = index;
    });
  }


  @override
  void initState() {
    super.initState();
    movieListModel.loadMovies();
  }
  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.read<MainPageModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'The Movie DB',
        ),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.menu,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => SessionDataProvider().setSessionId(null),
            icon: const Icon(
              Icons.logout_outlined,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
            ),
            color: const Color.fromRGBO(1, 180, 228, 1),
          ),
        ],
        backgroundColor: const Color.fromRGBO(3, 37, 65, 1.0),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: IndexedStack(
          index: _selectedDestination,
          children: [
            const NewsWidget(),
            NotifierProvider(
              model: movieListModel,
              child: const MovieListWidget(),
            ),
            const Text('TV Shows'),
            // TWShowListWidget(),
            const Text('People'),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
          selectedIndex: _selectedDestination,
          destinations: const [
            NavigationDestination(icon: Icon(Icons.fiber_new), label: 'News'),
            NavigationDestination(icon: Icon(Icons.movie), label: 'Movies'),
            NavigationDestination(icon: Icon(Icons.live_tv), label: 'TV Shows'),
            NavigationDestination(icon: Icon(Icons.people), label: 'People'),
          ],
          onDestinationSelected: (int index) => onSelectTab(index)),
    );
  }
}