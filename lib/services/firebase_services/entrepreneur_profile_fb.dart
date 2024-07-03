import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditEntrepreneurData{
  
  Future<void> updateEntrepreneurDataToFirestore(
  String nameSurnameController, 
  String usernameController, 
  String locationController,
  List<String> selectedFields,
  List<String> selectedFeatures,
) async {
  User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    try {
      // Update document in 'entrepreneurs' collection
      await FirebaseFirestore.instance.collection('entrepreneur').doc(user.uid).set({
        'username': usernameController,
        'name': nameSurnameController,
        'location': locationController,
        'fields': selectedFields,
        'entrepreneurFeatures': selectedFeatures,
      }, SetOptions(merge: true)); // Use set with merge option

      // Update document in 'userCollection' collection
      await FirebaseFirestore.instance.collection('userCollection').doc(user.uid).set({
        'username': usernameController,
        'name': nameSurnameController,
        'location': locationController,
      }, SetOptions(merge: true)); // Use set with merge option

      print('User data updated in Firestore successfully!');
    } catch (e) {
      print('Error updating user data in Firestore: $e');
    }
  } else {
    print('User data was not updated.');
  }
}

}