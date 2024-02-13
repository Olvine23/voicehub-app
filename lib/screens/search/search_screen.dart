import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> tabs = ['Health',' Politics' ,'Art' , 'Food ', 'Sciences'];
    return DefaultTabController(
      initialIndex: 0,
      length: tabs.length,
      child: Scaffold(
          appBar: AppBar(
            leading: const Icon(Icons.menu),
          ),
          body: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              DiscoverNews(),
              CategoryNews(
                tabs: tabs,
              )
            ],
          )),
    );
  }
}

class CategoryNews extends StatelessWidget {
  const CategoryNews({
    super.key,
    required this.tabs,
  });

  final List<String> tabs;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          isScrollable: true,
            tabs: tabs
                .map((tab) => Tab(
                      icon: Text(tab),
                    ))
                .toList())
      ],
    );
  }
}

class DiscoverNews extends StatelessWidget {
  const DiscoverNews({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
       
      child: TextFormField(
        decoration: InputDecoration(
            fillColor: Colors.grey.shade200,
            filled: true,
            hintText: "Search for poems, artists or stories ...",
            prefixIcon: Icon(Icons.search),
            suffixIcon:
                RotatedBox(quarterTurns: 1, child: Icon(Icons.tune)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none)),
      ),
    );
  }
}
