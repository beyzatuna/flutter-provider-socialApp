import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_project/providers/actor_providers/ecosystemActor_selection_provider.dart';

class EcosystemActorSelectFeatures extends StatefulWidget  {

  final String userId;
  const EcosystemActorSelectFeatures({required this.userId});

@override
_EcosystemActorSelectFeaturesState createState() =>
      _EcosystemActorSelectFeaturesState();

}
class _EcosystemActorSelectFeaturesState
  extends State <EcosystemActorSelectFeatures> {
  List<String> fields = ["investment", "mentoring", "education technology", "support", "networking"];
  List<String> ecosystemActorFeatures = ["supportive", "visionary", "open to collaboration", "ready to take risks", "understanding entrepreneurs", "fair", "effective communicator", "approachable", "reliable", "positive"];

  @override
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
                          Provider.of<EcosystemActorSelectionProvider>(context, listen: false)
                              .toggleFieldSelection(value);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Provider.of<EcosystemActorSelectionProvider>(context)
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
                  for (String value in ecosystemActorFeatures)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Provider.of<EcosystemActorSelectionProvider>(context, listen: false)
                              .toggleFeatureSelection(value);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Provider.of<EcosystemActorSelectionProvider>(context)
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
                      Provider.of<EcosystemActorSelectionProvider>(context, listen: false)
                          .selectedFields;
                  List<String> selectedFeatures =
                      Provider.of<EcosystemActorSelectionProvider>(context, listen: false)
                          .selectedFeatures;

                  // Firestore servisini kullanarak veriyi güncelle
                  await Provider.of<EcosystemActorSelectionProvider>(context, listen: false)
                    .saveEcosystemActorSelection(selectedFeatures, selectedFields);

                  // ignore: use_build_context_synchronously
                  await Navigator.pushReplacementNamed(context, '/ecosystemActor_profile_page');
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