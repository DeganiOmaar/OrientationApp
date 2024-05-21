// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orientation_app/actualite/homescreen.dart';
import 'package:orientation_app/describeapp/first.dart';
import 'package:orientation_app/firebase_options.dart';
import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  myrequestForPerrmission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  getToken() async {
    String? mytoken = await FirebaseMessaging.instance.getToken();
    print("============================================");
    print(mytoken);
  }

  sendMessage({required String title, required String message}) async {
    var headersList = {
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
      'Content-Type': 'application/json',
      'Authorization':
          'AAAA_v2Iu4c:APA91bE3fzCuUt5Nr1BSHzbJoHDo9iDBFZAASOHegmZ8_1kFKIH-qME23Yof5AY_6NlHnCllhnj6CIjNEVCUPesD-y24owe_lnclQJMlkpj10UxsJECP0EWe4pEf5lYKgctHnDu1GwWx'
    };
    var url = Uri.parse('https://fcm.googleapis.com/fcm/send');

    var body = {
      "to": "token from firebase",
      "notification": {
        "title": title,
        "body": message,
        "mutable_content": true,
        "sound": "Tri-tone"
      }
    };

    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print(resBody);
    } else {
      print(res.reasonPhrase);
    }
  }

@override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('======================User is currently signed out!');
      } else {
        print('===================User is signed in!');
      }
    });
    myrequestForPerrmission();
    getToken();
    super.initState();
  }
  
  
  @override

  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirebaseAuth.instance.currentUser == null
          ? const FirstPage()
          : const HomeScreen(),
    );
  }
}
