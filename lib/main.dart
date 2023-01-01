import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'authenticaion/presentation_layer/screens/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget
{
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context)
  {
    return Sizer(builder: (context , orientaion , deviceType){
      return MaterialApp (
        debugShowCheckedModeBanner: false,
        title: 'الادارة',
        theme: ThemeData
          (primarySwatch: Colors.blue,),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('ar', 'AE'), // English, no country code
        ],
        home: LoginScreen() ,

      ) ;
    });
  }
}