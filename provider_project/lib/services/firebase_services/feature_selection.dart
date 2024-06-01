
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthService {

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
 User? user = FirebaseAuth.instance.currentUser;

    
 Future<void> saveUserData(
  String userId,
  String name,
  String username,
  String location,
  String userType,
) async {
  try {
    // Common user data
    
    await _firestore.collection('userCollection').doc(userId).set({
      'name': name,
      'username': username,
      'location': location,
      'userType': userType,
    });

    // UserType specific data
    if (userType == 'entrepreneur') {
      await _firestore.collection('entrepreneur').doc(userId).set({
        'name': name,
        'username': username,
        'location': location,
      });
    } else if (userType == 'ecosystemActor') {
      await _firestore.collection('ecosystemActor').doc(userId).set({
        'name': name,
        'username': username,
        'location': location,
      });
    }

  } catch (e) {
    print('Firestore save error: $e');
  }
}

Future<void> updateEntrepreneurSelection(
  List<String> selectedFields, 
  List<String> selectedFeatures,
) async {
  User? user = FirebaseAuth.instance.currentUser;
  
  try {
    if (user != null && user.uid.isNotEmpty) {
      await _firestore.collection('entrepreneur').doc(user.uid).update({
        'fields': selectedFields,
        'entrepreneurFeatures': selectedFeatures,
      });
    } else {
      print('Error updating user selection: User ID is null or empty.');
    }
  } catch (e) {
    // Handle any errors that might occur
    print('Error updating user selection: $e');
  }
}

Future<void> updateEcosystemActorSelection(
  List<String> selectedFields, 
  List<String> selectedFeatures,
) async {
  User? user = FirebaseAuth.instance.currentUser;
  
  try {
    if (user != null && user.uid.isNotEmpty) {
      await _firestore.collection('ecosystemActor').doc(user.uid).update({
        'fields': selectedFields,
        'ecosystemActorFeatures': selectedFeatures,
      });
    } else {
      print('Error updating user selection: User ID is null or empty.');
    }
  } catch (e) {
    // Handle any errors that might occur
    print('Error updating user selection: $e');
  }
}

}