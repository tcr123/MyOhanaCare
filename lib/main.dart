import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ohana_care/provider/auth_provider.dart';
import 'package:ohana_care/provider/calendar_provider.dart';
import 'package:ohana_care/screen/auth/sign_in.dart';
import 'package:provider/provider.dart';
import 'package:ohana_care/provider/chat_provider.dart';
import 'package:ohana_care/provider/models_provider.dart';
import 'package:ohana_care/provider/education_provider.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting().then((_) => runApp(MultiProvider(providers: [
    ChangeNotifierProvider.value(value: AuthProvider()),
    ChangeNotifierProvider.value(value: CalendarProvider()),
    ChangeNotifierProvider.value(value: EducationProvider()),
  ], child: const MyApp())));
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
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ModelProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider())
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
