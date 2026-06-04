import 'package:flutter/material.dart';
import 'package:moviehub/const.dart';
import 'package:moviehub/riverpod/movie_riverpod.dart';
import 'package:moviehub/screens/profile_screen.dart';
import 'package:moviehub/widget/search_list.dart';
import 'package:moviehub/widget/tab_content.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
     
      if(context.mounted){
        ref.read(movieProvider).loadMovies();
                     }
      
    });
  
  }
    TextEditingController get searchController => _searchController;


  @override
  Widget build(BuildContext context) {
   final movieProviders= ref.watch(movieProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Search Movies..',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: secondaryColor),
                ),
                style: TextStyle(color: secondaryColor),
                onChanged: (value) {
                  movieProviders.searchMovies(value);
                },
              )
            : Text('MovieHub',style: TextStyle(fontFamily:"Lato")),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                _searchController.clear();
                movieProviders.searchResult.clear();
              });
            },
            icon: Icon(_isSearching ? Icons.close : Icons.search),
          ),
          IconButton(onPressed:(){
            Navigator.push(context,MaterialPageRoute(builder: (context)=>
            ProfileScreen()
            ),);
          }, icon: Icon(Icons.person))
        ],
        bottom: _isSearching
            ? null
            : TabBar(
                controller: _tabController,
                isScrollable: true,
                tabs: [
                  Tab(text: 'Now Playing'),
                  Tab(text: 'Popular'),
                  Tab(text: 'Top Rated'),
                  Tab(text: 'UpComing'),
                ],
              ),
      ),
      body: _isSearching
          ? SearchList(movieprovider: movieProviders,searchController:searchController ,)
          : TabContent(tabController: _tabController, movieprovider: movieProviders),
    );
  }
  
} 