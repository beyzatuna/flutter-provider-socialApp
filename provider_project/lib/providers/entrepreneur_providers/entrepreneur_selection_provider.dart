import 'package:flutter/material.dart';
import 'package:provider_project/services/firebase_services/feature_selection.dart';

class EntrepreneurSelectionProvider extends ChangeNotifier {
  List<String> selectedFields = [];
  List<String> selectedFeatures = [];
  final AuthService _authService = AuthService();

  EntrepreneurSelectionProvider(AuthService authService);

  void toggleFieldSelection(String value) {
    if (selectedFields.contains(value)) {
      selectedFields.remove(value);
    } else {
      selectedFields.add(value);
    }
    notifyListeners();
  }

  void toggleFeatureSelection(String value) {
    if (selectedFeatures.contains(value)) {
      selectedFeatures.remove(value);
    } else {
      selectedFeatures.add(value);
    }
    notifyListeners();
  }

  Future<void> saveEntrepreneurSelection(
    List<String> selectedFields, 
    List<String> selectedFeatures
  ) async {
    // Kullanıcı bilgilerini Firestore'a kaydetme
    await _authService.updateEntrepreneurSelection(selectedFields, selectedFeatures);
  }
}
