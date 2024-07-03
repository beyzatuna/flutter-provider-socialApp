// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_project/providers/entrepreneur_providers/entrepreneur_profile_provider.dart';
import 'package:provider_project/widgets/custom_text_field.dart';


class EditstartupPage extends StatefulWidget {

  final String userId;
  final Map<String, dynamic> startupData;

  EditstartupPage({super.key, required this.userId, required this.startupData});

  @override
  // ignore: library_private_types_in_public_api
  _EditstartupPageState createState() => _EditstartupPageState();
}

class _EditstartupPageState extends State<EditstartupPage> {
  TextEditingController startupNameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController sectorController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController storyController = TextEditingController();
  TextEditingController socialMediaController = TextEditingController();

  bool isEditMode = false; // Flag to check if it's in edit mode
  @override
  void initState() {
    super.initState();

     // Initialize controllers with existing data
  startupNameController.text = widget.startupData['startup_name'] ?? '';
  sectorController.text = widget.startupData['sector'] ?? '';
  locationController.text = widget.startupData['location'] ?? '';
  descriptionController.text = widget.startupData['description'] ?? '';
  storyController.text = widget.startupData['story'] ?? '';
  socialMediaController.text = widget.startupData['social_media'] ?? '';
  }
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Edit startup'),
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('startup Name:'),
            CustomTextField(
              controller: startupNameController,
             
                labelText: 'Enter startup Name',
              
            ),
            const SizedBox(height: 16),
            const Text('Location:'),
            CustomTextField(
              controller: locationController,
                labelText: 'Enter Location',
            ),
            const SizedBox(height: 16),
            const Text('Sector:'),
            CustomTextField(
              controller: sectorController,
                labelText: 'Enter Sector',

            ),
            const SizedBox(height: 16),
            const Text('Description:'),
            CustomTextField(
              controller: descriptionController,           
                labelText: 'Enter Description',            
            ),
            const SizedBox(height: 16),
            const Text('Story:'),
            CustomTextField(
              controller: storyController,
                labelText: 'Enter Story', 
            ),
            const SizedBox(height: 16),
            const Text('Social Media:'),
            CustomTextField(
              controller: socialMediaController,
                labelText: 'Enter Social Media',              
            ),
            const SizedBox(height: 16),
        ElevatedButton(
        onPressed: () async {
          await Provider.of<EditStartupDataProvider>(context, listen: false)
            .saveOrUpdateStartupData(
              context,
              startupNameController.text,
              locationController.text,
              sectorController.text,
              descriptionController.text,
              storyController.text,
              socialMediaController.text
            );
          Provider.of<LoadStartupDataProvider>(context, listen: false).loadStartupData(widget.userId);

          Navigator.pop(context, true);

          // Profil sayfasında startup bilgilerini güncelle
        },
        child: const Text('Save startup'),
      ),
          ],
        ),
      ),
    ),
  );
}

}
