import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple/module/login/login_page.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        centerTitle: false,
        title: Padding(
          padding: EdgeInsets.only(left: 16),
          child: Text(
            "Profile",
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            Get.offAll(LoginPage());
          },
          child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor.withOpacity(.6),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 32.0,
                ),
                child: Text("Logout"),
              )),
        ),
      ),
    );
  }
}
