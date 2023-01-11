
import 'package:albaraka_management/src/core/local/shared_prefrences.dart';
import 'package:albaraka_management/src/core/services/dep_injection.dart';
import 'package:albaraka_management/src/modules/authenticaion/presentation_layer/bloc/auth_bloc.dart';
import 'package:albaraka_management/src/modules/main/presentation_layer/screens/main_screen.dart';
import 'package:albaraka_management/src/modules/staff/presentation_layer/bloc/staff_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'src/modules/main/presentation_layer/bloc/main_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ServiceLocator().init();
  await  Firebase.initializeApp();
  await  CacheHelper.init();
 // firebase.firestore().settings({ experimentalForceLongPolling: true });
  runApp(MyApp());
}

class MyApp extends StatelessWidget
{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context)
  {
    return Sizer(builder: (context , orientaion , deviceType){
      return MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (BuildContext context) => AuthBloc(AuthInitial()),
          ),
          BlocProvider<MainBloc>(
            create: (BuildContext context) => MainBloc(MainInitial()),
          ),
          BlocProvider<StaffBloc>(
            create: (BuildContext context) => StaffBloc(StaffInitial()),
          ),
        ],
        child: MaterialApp (
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
          home: MainScreen() ,

        ),
      ) ;
    });
  }
}