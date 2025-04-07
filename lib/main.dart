
import 'package:firebase_core/firebase_core.dart';
import 'package:firebasewithnotification/controller/cart_provider.dart';
import 'package:firebasewithnotification/controller/favorite_provider.dart';
import 'package:firebasewithnotification/controller/order_provider.dart';
import 'package:firebasewithnotification/view/screens/delivery_hero_screen.dart';
import 'package:firebasewithnotification/view/screens/history_screen.dart';
import 'package:firebasewithnotification/view/screens/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'components/applocal.dart';
import 'firebase_options.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context)=>OrderProvider()),
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),

      ],

      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',

      theme: ThemeData(



        useMaterial3: true,
      ),
      home: SplashScreen(),

         localizationsDelegates: [
           AppLocale.delegate,
           GlobalMaterialLocalizations.delegate,
           GlobalWidgetsLocalizations.delegate,
         ],
      supportedLocales: [
        Locale("en",""),
        Locale("ar",""),
      ],
      localeResolutionCallback: (currentLang,supportLang){
         if(currentLang!=null){
           for(Locale locale in supportLang){
             if(locale.languageCode==currentLang.languageCode){return currentLang;}
           }
           return supportLang.first;
         }
      },
          );



  }
}

