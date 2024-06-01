import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_project/providers/entrepreneur_providers/entrepreneur_selection_provider.dart';


class EntrepreneurSelectFeatures extends StatefulWidget {
  final String userId;

  EntrepreneurSelectFeatures({required this.userId});

  @override
  _EntrepreneurSelectFeaturesState createState() =>
      _EntrepreneurSelectFeaturesState();
     
}

class _EntrepreneurSelectFeaturesState
    extends State<EntrepreneurSelectFeatures> {
  List<String> fields = ["product", "sales_marketing", "design", "operation", "engineering"];
  List<String> entrepreneurFeatures = ["creative", "challenger", "leader", "problem-solver", "entrepreneur-spirit", "risk-strategist", "patient", "team-player", "professional", "adaptation-expert"];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Multiple Choice Buttons'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Which area are you responsible?'),
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  for (String value in fields)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Provider.of<EntrepreneurSelectionProvider>(context, listen: false)
                              .toggleFieldSelection(value);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Provider.of<EntrepreneurSelectionProvider>(context)
                                  .selectedFields
                                  .contains(value)
                              ? Colors.blue
                              : Colors.grey,
                        ),
                        child: Text(value),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 20),
              const Text('Choose 5 features that make you highlight in your startup:'),
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  for (String value in entrepreneurFeatures)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Provider.of<EntrepreneurSelectionProvider>(context, listen: false)
                              .toggleFeatureSelection(value);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Provider.of<EntrepreneurSelectionProvider>(context)
                                  .selectedFeatures
                                  .contains(value)
                              ? Colors.blue
                              : Colors.grey,
                        ),
                        child: Text(value),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 20),


              ElevatedButton(
                onPressed: () async {
                  // Access selected fields and features using the provider
                  List<String> selectedFields =
                      Provider.of<EntrepreneurSelectionProvider>(context, listen: false)
                          .selectedFields;
                  List<String> selectedFeatures =
                      Provider.of<EntrepreneurSelectionProvider>(context, listen: false)
                          .selectedFeatures;

                  // Firestore servisini kullanarak veriyi güncelle
                  await Provider.of<EntrepreneurSelectionProvider>(context, listen: false)
                    .saveEntrepreneurSelection(selectedFeatures, selectedFields);

                  // ignore: use_build_context_synchronously
                  await Navigator.pushReplacementNamed(context, '/entrepreneur_profile_page');
                },
                child: const Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
