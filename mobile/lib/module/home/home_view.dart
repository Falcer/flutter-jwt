import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Home"),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 24.0),
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor.withOpacity(.6),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 24.0),
              child: Text("Hello $index"),
            ),
          );
        },
      ),
    );
  }
}
