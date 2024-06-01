import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_project/providers/user_providers/user_info_form_provider.dart';
import 'package:provider_project/widgets/custom_button.dart';
import 'package:provider_project/widgets/custom_text_field.dart';

class UserInfoForm extends StatefulWidget {
  final String userId;

  UserInfoForm({required this.userId});

  @override
  _UserInfoFormState createState() => _UserInfoFormState();
}

class _UserInfoFormState extends State<UserInfoForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  String userType = ''; // Added to store selected user type

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Info Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           CustomTextField(
              controller: nameController,
              labelText: 'Name Surname',
            ),
            CustomTextField(
              controller: usernameController,
              labelText: 'Username',
            ),
            CustomTextField(
              controller: locationController,
              labelText: 'Location',
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('User Type'),
                Row(
                  children: [
                    Radio(
                      value: 'entrepreneur',
                      groupValue: userType,
                      onChanged: (value) {
                        setState(() {
                          userType = value.toString();
                        });
                      },
                    ),
                    const Text('Entrepreneur'),
                    Radio(
                      value: 'ecosystemActor',
                      groupValue: userType,
                      onChanged: (value) {
                        setState(() {
                          userType = value.toString();
                        });
                      },
                    ),
                    const Text('Ecosystem Actor'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            CustomButton(
            onPressed: () async {
              bool isUsernameUnique = await Provider.of<UserProvider>(context, listen: false)
              .isUsernameUnique(usernameController.text.trim());


              if (isUsernameUnique) {
              
                // ignore: use_build_context_synchronously
                await Provider.of<UserProvider>(context, listen: false).addUserToCollection(
                  context,
                  widget.userId,
                  nameController.text,
                  usernameController.text,
                  locationController.text,
                  userType,
                );

                
              } else {
                print('Username is not unique');
              }
            },
            text: 'Save',
            
          ),

          ],
        ),
      ),
    );
  }
}
