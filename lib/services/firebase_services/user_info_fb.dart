import 'package:cloud_firestore/cloud_firestore.dart';


class UserInfoFb {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addUserToCollection(String userId, String name, String username, String location, String userType) async {
  try {
    assert(userId.isNotEmpty, 'User ID cannot be empty');

    // Add user to 'userCollection'
    await _firestore.collection('userCollection').doc(userId).set({
      'name': name,
      'username': username,
      'location': location,
      'userType': userType,
    });

    // Add user to specific collection based on userType
    if (userType == 'entrepreneur') {

      await _firestore.collection('entrepreneur').doc(userId).set({
        'name': name,
        'username': username,
        'location': location,
        'userType': userType,
      });
    }else if (userType=='ecosystemActor'){
        await _firestore.collection('ecosystemActor').doc(userId).set({

        'name': name,
        'username': username,
        'location': location,
        'userType': userType,
      });

    }

  } catch (e) {
    print('Error in addUserToCollection: $e');
  }
}
}
