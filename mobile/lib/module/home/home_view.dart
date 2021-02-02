import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple/module/profile/profile_page.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Padding(
          padding: EdgeInsets.only(left: 16),
          child: Text(
            "Home",
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        actions: [
          Tooltip(
            message: 'Profile',
            child: Padding(
              padding: EdgeInsets.only(right: 16),
              child: IconButton(
                icon: Icon(
                  Icons.person_outline,
                  color: Theme.of(context).iconTheme.color,
                ),
                onPressed: () {
                  Get.to(ProfilePage());
                },
              ),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _getData();
        },
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 24.0),
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: EdgeInsets.only(bottom: 16.0),
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
      ),
    );
  }

  // TODO: Get All Data
  void _getData() async {}
}
