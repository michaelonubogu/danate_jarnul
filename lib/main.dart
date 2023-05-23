import 'dart:io';
import 'package:dante/database/local_database.dart';
import 'package:dante/model/journal_model/journal_model.dart';
import 'package:dante/model/profile_model/profile_model.dart';
import 'package:dante/notification/notification.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dante/view/flash/flas_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:sizer/sizer.dart';

import 'controller/auth_controller/auth_controller.dart';
import 'model/admirers_model/admirers_model.dart';
import 'model/auth_model/email_verify_model.dart';
import 'model/auth_model/initialData_model.dart';
import 'model/dates_model/dates_screen_model.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', //id
    'High Importance Notifications', //title
    // 'This channel is used for important notifications.', //description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage) async {
  await Firebase.initializeApp();
  var message;
  print('A bg message just showed up : ${message.messageId}');
}

void main() async {
  // WidgetsBinding.instance?.ensureVisualUpdate();
  WidgetsFlutterBinding.ensureInitialized();
  NotificationServices.initNotification();
  Directory appDocDir = await getApplicationDocumentsDirectory();

 await Hive
    ..init(appDocDir.path)
    ..registerAdapter(InitialDataModelAdapter())
    ..registerAdapter(AdmirerModelAdapter())
    ..registerAdapter(DatesModelAdapter())
    ..registerAdapter(ProfileModelAdapter())
    ..registerAdapter(JournalModelAdapter())
    ..registerAdapter(LoginModelAdapter())
  ;

    //initial admirers profile
    await Hive.openBox<Map>('initial_Data');
    await Hive.openBox<LoginModel>('login');
    await Hive.openBox<ProfileModel>('profiles');
    await Hive.openBox<AdmirerModel>("admirers");
    await Hive.openBox<DatesModel>("dates");
    await Hive.openBox<JournalModel>("journals");

  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
                android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              // channel.description,
              color: Colors.green,
              playSound: true,
              icon: '@mipmap/ic_launcher',
            )));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title.toString()),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(notification.body.toString()),
                    ],
                  ),
                ),
              );
            });
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return Sizer(
        builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          title: 'dante',
          theme: ThemeData(
              colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red),
              fontFamily: "themeFont",
          ),
          debugShowCheckedModeBanner: false,
          home: FlashScreen(),
        );
      }
    );
  }
}
