import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:video_player_admin/providers/user_provider.dart';

import 'package:video_player_admin/views/login_screen.dart';
import 'package:video_player_admin/views/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isIOS) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyCbdziNh1lnJFPA8r1fFgNqjk44KKjbXg4",
            appId: "1:4815928025:ios:7df0b2dbc3b84044681cc8",
            messagingSenderId: "4815928025",
            projectId: "videoplayer-4f23e",
            storageBucket: "videoplayer-4f23e.appspot.com",
            ));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: GetMaterialApp(
        title: 'Video Player Admin',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
