import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider_project/services/firebase_services/entrepreneur_edit_startup_fb.dart';
import 'package:provider_project/services/firebase_services/entrepreneur_profile_fb.dart';

class EntrepreneurDataProvider with ChangeNotifier {
  
  Map<String, dynamic> _userData = {};

  Map<String, dynamic> get userData => _userData;

  Future<void> loadUserData() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        DocumentSnapshot userSnapshot =
            await FirebaseFirestore.instance.collection('entrepreneur').doc(user.uid).get();

        if (userSnapshot.exists) {
          _userData = userSnapshot.data() as Map<String, dynamic>;
          notifyListeners(); // Notify listeners about the state change
        }
      } catch (e) {
        print('Error getting user data from Firestore: $e');
      }
    }
  }
}
class LoadStartupDataProvider with ChangeNotifier{
  Map<String, dynamic> _startupData = {};
  Map<String, dynamic> get startupData => _startupData;
  Future<void> loadStartupData(String userId) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        DocumentSnapshot userSnapshot =
            await FirebaseFirestore.instance.collection('startup').doc(user.uid).get();

        if (userSnapshot.exists) {
          _startupData = userSnapshot.data() as Map<String, dynamic>;
          notifyListeners(); // Notify listeners about the state change
        }
      } catch (e) {
        print('Error getting user data from Firestore: $e');
      }
    }
  }

}



class EditEntrepreneurDataProvider with ChangeNotifier{
  List<String> selectedFields = [];
  List<String> selectedFeatures = [];
  final EditEntrepreneurData _editEData = EditEntrepreneurData();

  EditEntrepreneurDataProvider(EditEntrepreneurData editEntrepreneurData);

  Future<void> updateEntrepreneurDataToFirestore(
    BuildContext context,
    String nameSurnameController, 
    String usernameController, 
    String locationController,
    List<String> selectedFields,
    List<String> selectedFeatures,

  ) async {
    // Kullanıcı bilgilerini Firestore'da güncelleme
    await _editEData.updateEntrepreneurDataToFirestore(nameSurnameController, usernameController, locationController, selectedFields, selectedFeatures);
    notifyListeners();

  }
  
}


class EditStartupDataProvider with ChangeNotifier{

  final EditStartupData _editSDataProvider = EditStartupData();
  EditStartupDataProvider(EditStartupData editStartupData); 

  Future <void> saveOrUpdateStartupData(
    BuildContext context,
    String startupNameController,
    String locationController,
    String sectorController,
    String descriptionController,
    String storyController,
    String socialMediaController,
  ) async{
    await _editSDataProvider.saveOrUpdateStartupData(startupNameController,locationController,sectorController,descriptionController,storyController,socialMediaController);
    notifyListeners();
  }
}




