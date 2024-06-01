// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_project/providers/entrepreneur_providers/entrepreneur_profile_provider.dart';
import 'package:provider_project/providers/user_providers/user_info_form_provider.dart';
import 'package:provider_project/widgets/custom_text_field.dart';

class EditEntrepreneurDataPage extends StatefulWidget {
  final String userId;
  final Map<String, dynamic> userData;


  EditEntrepreneurDataPage({super.key, required this.userId, required this.userData});

  @override
  _EditEntrepreneurDataPageState createState() => _EditEntrepreneurDataPageState();
}


class _EditEntrepreneurDataPageState extends State<EditEntrepreneurDataPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController nameSurnameController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  List<String> fields = ["product", "sales_marketing", "design", "operation", "engineering"];
  List<String> entrepreneurFeatures = ["creative", "challenger", "leader", "problem-solver", "entrepreneur-spirit", "risk-strategist", "patient", "team-player", "professional", "adaptation-expert"];

  List<String> selectedFields = [];
  List<String> selectedFeatures = [];

  @override
  void initState() {
    super.initState();

     // Initialize controllers with existing data
  usernameController.text = widget.userData['username'] ?? '';
  nameSurnameController.text = widget.userData['name'] ?? '';
  locationController.text = widget.userData['location'] ?? '';

  // Check if 'fields' key exists in userData
  if (widget.userData.containsKey('fields')) {
    selectedFields = List<String>.from(widget.userData['fields']);
  }

  // Check if 'entrepreneurFeatures' key exists in userData
  if (widget.userData.containsKey('entrepreneurFeatures')) {
    selectedFeatures = List<String>.from(widget.userData['entrepreneurFeatures']);
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              controller: usernameController,
              labelText: 'Username',
            ),
            CustomTextField(
              controller: nameSurnameController,
              labelText: 'Name Surname',
            ),
            CustomTextField(
              controller: locationController,
              labelText: 'Location',
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('Which area are you responsible?'),
                  Wrap(
                    alignment: WrapAlignment.center,
                    children: fields.map((value) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              toggleFieldSelection(value);
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            primary: selectedFields.contains(value) ? Colors.blue : Colors.grey,
                          ),
                          child: Text(value),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  const Text('Choose 5 features that make you highlight in your startup:'),
                  Wrap(
                    alignment: WrapAlignment.center,
                    children: entrepreneurFeatures.map((value) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              toggleFeatureSelection(value);
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            primary: selectedFeatures.contains(value) ? Colors.blue : Colors.grey,
                          ),
                          child: Text(value),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () async {

                bool isUsernameUnique = await Provider.of<UserProvider>(context, listen: false)
              .isUsernameUnique(usernameController.text.trim());      
               if (isUsernameUnique) {

                await Provider.of<EditEntrepreneurDataProvider>(context, listen: false)
                  .updateEntrepreneurDataToFirestore(
                  context,
                  nameSurnameController.text,
                  usernameController.text,
                  locationController.text,
                  selectedFeatures,
                  selectedFields,

                  
                );
                Navigator.pop(context, true);

              }else{
                 print('Username is not unique');
              }
              },
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }

 void toggleFieldSelection(String value) {
    if (selectedFields.contains(value)) {
      selectedFields.remove(value);
    } else {
      selectedFields.add(value);
    }
 }

 void toggleFeatureSelection(String value) {
    if (selectedFeatures.contains(value)) {
      selectedFeatures.remove(value);
    } else {
      selectedFeatures.add(value);
    }
    
  }
}
