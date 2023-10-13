import 'package:flutter/material.dart';
import 'package:todo_c9_friday/screens/register/login.dart';
import 'package:todo_c9_friday/screens/register/signup.dart';

class RegisterScreen extends StatelessWidget {
 static const String routeName="Logi";
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(child: Text("Login")),
              Tab(child: Text("Sign Up")),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            LoginTab(),
            SignUpTab()
          ],
        ),
      ),
    );
  }
}
