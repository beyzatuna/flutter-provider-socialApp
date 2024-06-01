import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchProvider extends ChangeNotifier {
  TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> searchResults = [];

  TextEditingController get searchController => _searchController;
  List<Map<String, dynamic>> get results => searchResults;

  void search() async {
    String searchTerm = _searchController.text.trim().toLowerCase();
    searchResults.clear();

    if (searchTerm.isNotEmpty) {
      await searchUsers('entrepreneur', searchTerm, 'username', 'name');
      await searchUsers('ecosystemActor', searchTerm, 'username', 'name');
    }

    notifyListeners();
  }

  Future<void> searchUsers(String collection, String searchTerm, String field1, String field2) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('userCollection')
        .where(field1, isGreaterThanOrEqualTo: searchTerm)
        .where(field1, isLessThan: searchTerm + 'z')
        .get();

    for (QueryDocumentSnapshot document in querySnapshot.docs) {
      Map<String, dynamic> userData = document.data() as Map<String, dynamic>;
      // Kullanıcı adını ekle
      userData['username'] = document.get('username');
      searchResults.add(userData);
    }
  }

  Future<List<Map<String, dynamic>>> getUserImprovements(String username) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('improvements')
        .where('username', isEqualTo: username)
        .get();
    List<Map<String, dynamic>> improvements = [];
    for (QueryDocumentSnapshot document in querySnapshot.docs) {
      Map<String, dynamic> improvementData = document.data() as Map<String, dynamic>;
      improvements.add(improvementData);
    }
    return improvements;
  }
}
