import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:provider_project/providers/actor_providers/ecosystemActor_selection_provider.dart';
import 'package:provider_project/providers/entrepreneur_providers/entrepreneur_profile_provider.dart';
import 'package:provider_project/providers/entrepreneur_providers/entrepreneur_selection_provider.dart';
import 'package:provider_project/providers/user_providers/search_provider.dart';
import 'package:provider_project/providers/user_providers/user_info_form_provider.dart';
import 'package:provider_project/screens/actor_screens/ecosystemActor_profile_page.dart';
import 'package:provider_project/screens/actor_screens/ecosystemActor_select_features.dart';
import 'package:provider_project/screens/auth_screens/login_screen.dart';
import 'package:provider_project/screens/entrepreneur_screens/entrepreneur_profile_page.dart';
import 'package:provider_project/screens/entrepreneur_screens/entrepreneur_select_features.dart';
import 'package:provider_project/screens/auth_screens/signup_screen.dart';
import 'package:provider_project/screens/common_screens/user_info_form.dart';
import 'package:provider_project/services/firebase_services/entrepreneur_edit_startup_fb.dart';
import 'package:provider_project/services/firebase_services/entrepreneur_profile_fb.dart';
import 'package:provider_project/services/firebase_services/feature_selection.dart';
import 'package:provider_project/services/firebase_services/user_info_fb.dart';

Future<void> initializeFirebase() async {
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyDKkv6YHgd4mvpF0BITOOblTCUcsAhaPFs',
      appId: '1:615230523314:android:23ae92789b8b0df97d86ab',
      messagingSenderId: '615230523314',
      projectId: 'test-e6741',
    ),
  );

  if (kIsWeb) {
    await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeFirebase();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(UserInfoFb()),
        ),
        ChangeNotifierProvider(
          create: (context) => EntrepreneurSelectionProvider(AuthService()),
        ),
        ChangeNotifierProvider(
          create: (context) => EcosystemActorSelectionProvider(AuthService()),
        ),
        ChangeNotifierProvider(
          create: (context) => EntrepreneurDataProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => EditEntrepreneurDataProvider(EditEntrepreneurData()),
        ),
        ChangeNotifierProvider(
          create: (context) => EditStartupDataProvider(EditStartupData()),
        ),
        ChangeNotifierProvider(
          create: (context) => LoadStartupDataProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SearchProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App',
      home: const SignUpScreen(),
      routes: {
        '/user_info_form': (context) => UserInfoForm(userId: ''),
        '/entrepreneur_select_features': (context) => EntrepreneurSelectFeatures(userId: ''),
        '/ecosystemActor_select_features': (context) => const EcosystemActorSelectFeatures(userId: ''),
        '/entrepreneur_profile_page': (context) => EntrepreneurProfilePage(userId: ''),
        '/ecosystemActor_profile_page': (context) => EcosystemActorProfile(userId: ''),
        '/signup_page': (context) => const SignUpScreen(),
        '/login_page': (context) => const LoginScreen(),
      },
    );
  }
}
