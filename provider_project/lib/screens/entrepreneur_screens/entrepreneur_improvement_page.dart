import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_project/providers/entrepreneur_providers/improvements_provider.dart';



class ImprovementsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ImprovementsProvider(),
      child: Consumer<ImprovementsProvider>(
        builder: (context, provider, _) {
          if (provider.improvements.isEmpty) { // Yalnızca veri yüklenmediyse yükle
            provider.loadImprovementsFromFirestore();
          }
          return ImprovementsPage();
        },
      ),
    );
  }
}


class ImprovementsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ImprovementsProvider>(context);
     if (provider.isLoading) {
      return CircularProgressIndicator(); // Eğer veriler yükleniyorsa, dairesel ilerleme göster
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Improvements'),
      ),
      body: ListView.builder(
        itemCount: provider.improvements.length,
        itemBuilder: (context, index) {
          return ImprovementCard(
            improvement: provider.improvements[index],
            onDelete: () {
              provider.deleteImprovementFromFirestore(
                provider.improvements[index].id,
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddImprovementDialog(context, provider);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddImprovementDialog(
      BuildContext context, ImprovementsProvider provider) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController dateController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Improvement'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              TextFormField(
                controller: dateController,
                decoration: InputDecoration(labelText: 'Date'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                provider.saveImprovementToFirestore(
                  title: titleController.text,
                  description: descriptionController.text,
                  date: dateController.text,
                );
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}


class ImprovementCard extends StatelessWidget {
  final Improvement improvement;
  final VoidCallback onDelete;

  ImprovementCard({required this.improvement, required this.onDelete});

  @override
Widget build(BuildContext context) {
  return Card(
    margin: EdgeInsets.all(8.0),
    child: ListTile(
      title: Text(improvement.title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(improvement.description),
          SizedBox(height: 4), 
          Text(improvement.date), 
        ],
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: onDelete,
      ),
    ),
  );
}
}
