import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ohana_care/provider/auth_provider.dart';
import 'package:ohana_care/provider/calendar_provider.dart';
import 'package:ohana_care/screen/auth/sign_in.dart';
import 'package:ohana_care/voicegpt/chatScreen.dart';
import 'package:provider/provider.dart' as provide;
import 'package:ohana_care/provider/chat_provider.dart';
import 'package:ohana_care/provider/models_provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting().then((_) => runApp(ProviderScope(child: MyApp())));
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
        provide.ChangeNotifierProvider(create: (_) => ChatProvider())
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
