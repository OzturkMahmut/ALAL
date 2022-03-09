import 'package:deneme1/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:deneme1/themes/themes.dart';
import 'package:deneme1/themes/config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'home_page.dart';
import 'login_page.dart';
import 'package:provider/provider.dart';

//TODO: USE CHIPS FOR THEME SELECTION
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    //webde açmak için
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyA96ot8T-axGlIKm061bImJVQqzQN4_9vc',
        appId: '1:534574566293:web:1cd923ebafcef7d7ac449c',
        messagingSenderId: '534574566293',
        projectId: 'alal-49417',
        storageBucket: 'alal-49417.appspot.com',
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void initState() {
    super.initState();
    currentTheme.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ALAL',
        theme: currentTheme.currentThemeDataa,
        darkTheme: CustomTheme.darkTheme,
        themeMode: currentTheme.currentThemeMode,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const MyHomePageFul(title: 'ALAL');
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }

            return const LoginPageFul();
          },
        ),
      ),
    );
  }
}
