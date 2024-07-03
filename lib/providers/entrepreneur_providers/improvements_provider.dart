import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ImprovementsProvider extends ChangeNotifier {
  final CollectionReference _improvementsCollection =
      FirebaseFirestore.instance.collection('improvements');

  List<Improvement> _improvements = [];

  List<Improvement> get improvements => _improvements;
  bool _isLoading = false; // Yeni eklenen satır

  bool get isLoading => _isLoading; // Yeni eklenen satır

  Future<void> loadImprovementsFromFirestore() async {
     if (_isLoading) return;
    try {
       _isLoading = true;
      String? user = FirebaseAuth.instance.currentUser?.uid;

      if (user != null) {
        QuerySnapshot querySnapshot = await _improvementsCollection
            .where('uid', isEqualTo: user)
            .get();

        _improvements = querySnapshot.docs.map((doc) {
          return Improvement(
            id: doc.id,
            title: doc['title'],
            description: doc['description'],
            date: doc['date'],
          );
        }).toList();
        notifyListeners();
      } else {
        print('User is not authenticated.');
      }
       notifyListeners(); 
    } catch (e) {
      print('Error loading improvements from Firestore: $e');
    }finally {
      _isLoading = false; // Yeni eklenen satır
    }
  }

  Future<void> saveImprovementToFirestore({
    required String title,
    required String description,
    required String date,
  }) async {
    try {
      String? user = FirebaseAuth.instance.currentUser?.uid;

      if (user != null) {
        DocumentReference result = await _improvementsCollection.add({
          'uid': user,
          'title': title,
          'description': description,
          'date': date,
        });

        _improvements.add(
          Improvement(
            id: result.id,
            title: title,
            description: description,
            date: date,
          ),
        );
        notifyListeners();
      } else {
        print('User is not authenticated.');
      }
    } catch (e) {
      print('Error saving improvement to Firestore: $e');
    }
  }

  Future<void> deleteImprovementFromFirestore(String id) async {
    try {
      await _improvementsCollection.doc(id).delete();
      _improvements.removeWhere((improvement) => improvement.id == id);
      notifyListeners();
      print('Improvement deleted from Firestore successfully!');
    } catch (e) {
      print('Error deleting improvement from Firestore: $e');
    }
  }
}

class Improvement {
  final String id;
  final String title;
  final String description;
  final String date;

  Improvement({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
  });
}
