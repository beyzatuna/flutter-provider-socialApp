import 'package:flutter/material.dart';

class EcosystemActorProfile extends StatelessWidget {
  final String userId;


  EcosystemActorProfile({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome EA',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}