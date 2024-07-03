import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditStartupData{


  Future <void> saveOrUpdateStartupData(
    String startupNameController,
    String locationController,
    String sectorController,
    String descriptionController,
    String storyController,
    String socialMediaController,

  ) async {
  User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    try {
      
        // If it's in edit mode, update the existing document
        await FirebaseFirestore.instance.collection('startup').doc(user.uid).set({
          'startup_name': startupNameController,
          'location': locationController,
          'sector': sectorController,
          'description': descriptionController,
          'story': storyController,
          'social_media': socialMediaController,
        },SetOptions(merge: true)); // Use set with merge option);
      
    } catch (e) {
      print('Error saving/update startup data to Firestore: $e');
    }
  }
}

}

