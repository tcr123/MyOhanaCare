import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ohana_care/provider/auth_provider.dart';
import 'package:ohana_care/provider/calendar_provider.dart';
import 'package:ohana_care/screen/auth/sign_in.dart';
import 'package:ohana_care/voicegpt/chatScreen.dart';
import 'package:provider/provider.dart' as provide;
import 'package:ohana_care/provider/chat_provider.dart';
import 'package:ohana_care/provider/models_provider.dart';
import 'package:ohana_care/provider/education_provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description: 'This channel is used for important notifications.', // description
  importance: Importance.high,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// receive notification background
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A background message just showed up: ${message.messageId}');
  await showNotification(message);
}

// show notification
Future<void> showNotification(RemoteMessage message) async {
  await flutterLocalNotificationsPlugin.show(
    message.hashCode,
    message.notification?.title,
    message.notification?.body,
    NotificationDetails(
      android: AndroidNotificationDetails(
        channel.id,
        channel.name,
        channelDescription: channel.description,
        icon: 'launch_background',
      ),
    ),
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    // Show a notification when a message is received while the app is in the foreground
    showNotification(message);
  });

  // Initialize local notifications for Android
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  initializeDateFormatting().then((_) => runApp(const ProviderScope(child: MyApp())));
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.dualRing
    ..maskType = EasyLoadingMaskType.custom
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.white
    ..backgroundColor = const Color.fromRGBO(0, 170, 170, 1)
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..maskColor = const Color.fromRGBO(0, 170, 170, 1).withOpacity(0.2)
    ..userInteractions = false;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return provide.MultiProvider(
      providers: [
        provide.ChangeNotifierProvider(create: (_) => AuthProvider()),
        provide.ChangeNotifierProvider(create: (_) => CalendarProvider()),
        provide.ChangeNotifierProvider(create: (_) => ModelProvider()),
        provide.ChangeNotifierProvider(create: (_) => ChatProvider()),
        provide.ChangeNotifierProvider(create: (_) => EducationProvider())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SignIn(),
        builder: EasyLoading.init(),
      ),
    );
  }
}
