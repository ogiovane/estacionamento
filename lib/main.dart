import 'package:estacionamento/firebase_options.dart';
import 'package:estacionamento/screens/dashboard2.dart';
import 'package:estacionamento/screens/login_page.dart';
import 'package:estacionamento/widgets/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
  }

  final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  late final Future<FirebaseApp> _initialization;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: Utils.messengerKey,
      localizationsDelegates: [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('pt', 'BR'),
        Locale('en', '')
      ],
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        // fontFamily: 'OpenSans',


      ),
    );
  }
}
