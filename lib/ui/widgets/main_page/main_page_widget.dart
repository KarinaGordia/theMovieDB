import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_db/domain/domain.dart';
import 'package:the_movie_db/ui/ui.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedDestination = 0;
  final _screenFactory = ScreenFactory();

  void onSelectTab(int index) {
    if (_selectedDestination == index) return;
    setState(() {
      _selectedDestination = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final model = context.read<MainPageViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'The Movie DB',
        ),
        actions: [
          IconButton(
            onPressed: () => model.logOut(context),
            icon: const Icon(
              Icons.logout_outlined,
            ),
          ),
        ],
        backgroundColor: const Color.fromRGBO(3, 37, 65, 1.0),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: IndexedStack(
          index: _selectedDestination,
          children: [
            _screenFactory.makeNews(),
            _screenFactory.makeMovieList(),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
          selectedIndex: _selectedDestination,
          destinations: const [
            NavigationDestination(icon: Icon(Icons.fiber_new), label: 'News'),
            NavigationDestination(icon: Icon(Icons.movie), label: 'Movies'),
          ],
          onDestinationSelected: (int index) => onSelectTab(index)),
    );
  }
}
