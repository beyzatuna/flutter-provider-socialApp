import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_project/providers/user_providers/search_provider.dart';


class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<SearchProvider>(
          builder: (context, searchProvider, _) => Column(
            children: [
              TextField(
                controller: searchProvider.searchController,
                decoration: InputDecoration(labelText: 'Search'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  searchProvider.search();
                },
                child: Text('Search'),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: searchProvider.results.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(searchProvider.results[index]['username']),
                      onTap: () {
                        String selectedUsername = searchProvider.results[index]['username'] ?? '';
                        String selectedLocation = searchProvider.results[index]['location'] ?? '';
                        String selectedUserType = searchProvider.results[index]['userType'] ?? '';
                        navigateToProfile(context, selectedUsername, selectedLocation, selectedUserType);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void navigateToProfile(BuildContext context, String username, String location, String userType) {
    if(userType == 'entrepreneur'){
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfileScreen(username: username , location: location , userType : userType),
        ),
      );
    } else if(userType == 'ecosystemActor') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EcosystemActorProfileScreen(username: username , location: location , userType : userType),
        ),
      );
    }
  }
}

class ProfileScreen extends StatelessWidget {
  final String username;
  final String location;
  final String userType;
  ProfileScreen({required this.username , required this.location , required this.userType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Entrepreneur Profile'),
      ),
      body: Center(
        child: Text('Profile Screen for $username ,  $location'),
      ),
    );
  }
}

class EcosystemActorProfileScreen extends StatelessWidget {
  final String username;
  final String location;
  final String userType;
  EcosystemActorProfileScreen({required this.username , required this.location , required this.userType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ecosystem Actor Profile'),
      ),
      body: Center(
        child: Text('Profile Screen for $username , $location '),
      ),
    );
  }
}
