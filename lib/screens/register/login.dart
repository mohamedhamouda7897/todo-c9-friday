import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_c9_friday/layout/home_layout.dart';
import 'package:todo_c9_friday/providers/my_provider.dart';
import 'package:todo_c9_friday/shared/network/firebase_functions.dart';

class LoginTab extends StatelessWidget {
  LoginTab({super.key});

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var pro=Provider.of<MyProvider>(context);
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: emailController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'User Name',
                  hintText: 'Enter valid mail id as abc@gmail.com'),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  hintText: 'Enter your secure password'),
            ),
          ),
          Container(
            height: 50,
            width: 250,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(20)),
            child: ElevatedButton(
              onPressed: () {
                FirebaseFunctions.loginUser(
                    emailController.text,
                    passwordController.text, () {

                      pro.initMyUser();
                  Navigator.pushNamedAndRemoveUntil(
                      context, HomeLayout.routeName, (route) => false);

                  }, (message) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Error"),
                      content: Text(message),
                      actions: [
                        ElevatedButton(onPressed: () {}, child: Text("Okay"))
                      ],
                    ),
                  );
                });
              },
              child: Text(
                'Login',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
