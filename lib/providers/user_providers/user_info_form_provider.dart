import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider_project/screens/actor_screens/ecosystemActor_select_features.dart';
import 'package:provider_project/screens/entrepreneur_screens/entrepreneur_select_features.dart';
import 'package:provider_project/services/firebase_services/user_info_fb.dart';

class UserProvider with ChangeNotifier {
  final UserInfoFb _userInfoFb;

  UserProvider(this._userInfoFb);


Future<bool> isUsernameUnique(String username) async {
  print('Checking username uniqueness for: $username');

  RegExp allowedCharacters = RegExp(r'^[a-zA-Z0-9_]+$');

  Iterable<Match> matches = allowedCharacters.allMatches(username);

  if (matches.isEmpty) {
    print('Username contains invalid characters');
    return false;
  }

  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('userCollection')
      .where('username', isEqualTo: username)
      .get();

  print('Query result: ${querySnapshot.docs.isNotEmpty}');

  return querySnapshot.docs.isEmpty;
}



  Future<void> addUserToCollection(BuildContext context, String userId, String name, String username, String location, String userType) async {
    await _userInfoFb.addUserToCollection(userId, name, username, location, userType);
    notifyListeners();
    // ignore: use_build_context_synchronously
    await navigateToFeaturesPage(context, userId, userType);
  }

  Future<void> navigateToFeaturesPage(BuildContext context, String userId, String userType) async {
    if (userType=='entrepreneur'){
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EntrepreneurSelectFeatures(userId: userId)),
    );
  }else if(userType=='ecosystemActor'){
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EcosystemActorSelectFeatures(userId: userId)),
    );
  }
}
}



