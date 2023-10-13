import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_c9_friday/layout/home_layout.dart';
import 'package:todo_c9_friday/providers/my_provider.dart';
import 'package:todo_c9_friday/screens/register/register.dart';
import 'package:todo_c9_friday/shared/styles/themeing.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // FirebaseFirestore.instance.disableNetwork();
  runApp(ChangeNotifierProvider(
      create: (context) => MyProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return MaterialApp(
      initialRoute: provider.firebaseUser != null
          ? HomeLayout.routeName
          : RegisterScreen.routeName,
      theme: MyThemeData.lightTheme,
      debugShowCheckedModeBanner: false,
      routes: {
        RegisterScreen.routeName: (context) => RegisterScreen(),
        HomeLayout.routeName: (context) => HomeLayout(),
      },
    );
  }
}
