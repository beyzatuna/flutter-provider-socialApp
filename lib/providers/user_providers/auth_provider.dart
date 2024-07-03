import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider_project/screens/actor_screens/ecosystemActor_profile_page.dart';
import 'package:provider_project/screens/common_screens/user_info_form.dart';
import 'package:provider_project/screens/entrepreneur_screens/entrepreneur_profile_page.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signUpWithEmailAndPassword(BuildContext context, String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User user = result.user!;
      
      // Firestore kayıt işlemleri buraya eklenebilir.
      
      print('User ID in signUpWithEmailAndPassword: ${user.uid}');
      
      // AuthProvider ile bağlantılı Consumer'lar güncellenir.
      notifyListeners();
      
      // UserInfoForm sayfasına git
      _navigateToUserInfoForm(context, user.uid);
    } catch (e) {
      print('Error in signUpWithEmailAndPassword: $e');
    }
  }

  Future<void> _navigateToUserInfoForm(BuildContext context, String userId) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UserInfoForm(userId: userId)),
    );
  }


//LOGIN PROVIDER

Future<void> SignIn(BuildContext context, String email, String password) async {
  try {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    print("User Logged In: ${userCredential.user!.email}");

    // Firestore'dan userType'ı al
    String userType = await getUserType(userCredential.user!.uid);

    // Kullanıcının userType'ına göre uygun sayfaya yönlendir
    String userId = userCredential.user!.uid;
    navigateToProfilePage(context, userType, userId);

  } catch (e) {
    print("Error During Logged In: $e");
  }
}

Future<String> getUserType(String userId) async {
  DocumentSnapshot snapshot = await FirebaseFirestore.instance
      .collection('userCollection')
      .doc(userId)
      .get();

  // Firestore'dan userType'ı al, eğer yoksa varsayılan bir değer döndür
  return snapshot.exists ? snapshot['userType'] ?? 'default' : 'default';
}

Future<void> navigateToProfilePage(BuildContext context, String userType, String userId) async {
  switch (userType) {
    case "entrepreneur":
      Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EntrepreneurProfilePage(userId: '',)),
    );
      
      break;
    case "ecosystemActor":
      Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EcosystemActorProfile(userId: userId)),
    );
      break;
    
  }
}
}
