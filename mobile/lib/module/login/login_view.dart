import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple/module/home/home_page.dart';
import 'package:simple/module/login/http/login.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String username = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraint) => Container(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: IntrinsicHeight(
                child: Padding(
                    padding: const EdgeInsets.only(
                      top: 32.0,
                      bottom: 24.0,
                      left: 24,
                      right: 24,
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: SizedBox(
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Login",
                                  style: TextStyle(
                                    fontSize: 56,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  "Please sign in to continue",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 80,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .accentColor
                                        .withOpacity(.4),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 4.0,
                                      left: 16.0,
                                      right: 16.0,
                                    ),
                                    child: TextField(
                                      onChanged: (newVal) {
                                        setState(() {
                                          username = newVal;
                                        });
                                      },
                                      decoration: InputDecoration(
                                        labelText: "Username",
                                        labelStyle: Theme.of(context)
                                            .textTheme
                                            .subtitle2,
                                        border: InputBorder.none,
                                      ),
                                      textInputAction: TextInputAction.next,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 24,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .accentColor
                                        .withOpacity(.4),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 4.0,
                                      left: 16.0,
                                      right: 16.0,
                                    ),
                                    child: TextField(
                                      onChanged: (newVal) {
                                        setState(() {
                                          password = newVal;
                                        });
                                      },
                                      decoration: InputDecoration(
                                        labelText: "Password",
                                        labelStyle: Theme.of(context)
                                            .textTheme
                                            .subtitle2,
                                        border: InputBorder.none,
                                      ),
                                      obscureText: true,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (username.isEmpty || password.isEmpty) {
                              Get.snackbar(
                                "Oppss...",
                                "Fields can't be blank",
                              );
                              return;
                            }
                            login(username, password).then((res) {
                              if (!res["success"]) {
                                Get.snackbar(
                                  "Oppss...",
                                  res["message"],
                                );
                                return;
                              }
                              Get.offAll(
                                HomePage(),
                              );
                            }).catchError((_) {
                              Get.snackbar(
                                "Oppss...",
                                "Username or Password incorrect",
                              );
                              return;
                            });
                          },
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Theme.of(context).accentColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                                horizontal: 48.0,
                              ),
                              child: Text(
                                "Continue",
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .button
                                    .apply(
                                      color: Colors.white.withOpacity(.8),
                                    )
                                    .copyWith(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          ),
                        )
                      ],
                    )),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
