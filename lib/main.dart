import 'dart:developer';

import 'package:crudapp/Services/local_notification.dart';
import 'package:crudapp/core/multiprovider.wrapper.dart';
import 'package:crudapp/firebase_options.dart';
import 'package:crudapp/router/router.gr.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  messaging.getToken().then((value) => log(value.toString()));
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  LocalNotificationService.initilize();
  FirebaseMessaging.instance.getInitialMessage().then((event) {
    if (event != null) {
      print(
          '${event.notification!.title}${event.notification!.body} I am Coming From terminated');
    }
  });
  FirebaseMessaging.onMessage.listen((event) {
    LocalNotificationService.showNotificationOnForeground(event);
    print(
        '${event.notification!.title}${event.notification!.body} I am Coming From Foreground');
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(
        '${event.notification!.title}${event.notification!.body} I am Coming From backgroud');
  });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final _appRouter = AppRouter();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiproviderWrapper(
      child: MaterialApp.router(
          routerDelegate: _appRouter.delegate(),
          routeInformationParser: _appRouter.defaultRouteParser(),
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          builder: EasyLoading.init()),
    );
  }
}
