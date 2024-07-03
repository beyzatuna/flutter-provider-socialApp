import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider_project/providers/entrepreneur_providers/entrepreneur_profile_provider.dart';
import 'package:provider_project/screens/entrepreneur_screens/entrepreneur_edit_startup_data.dart';
import 'package:provider_project/screens/entrepreneur_screens/entrepreneur_edit_user_data.dart';
import 'package:provider_project/screens/entrepreneur_screens/entrepreneur_improvement_page.dart';
import 'package:provider_project/screens/common_screens/user_search_page.dart';
import 'package:provider_project/screens/auth_screens/login_screen.dart';

class EntrepreneurProfilePage extends StatefulWidget {
  final String userId;

  EntrepreneurProfilePage({Key? key, required this.userId}) : super(key: key);

  @override
  _EntrepreneurProfilePageState createState() => _EntrepreneurProfilePageState();
}

class _EntrepreneurProfilePageState extends State<EntrepreneurProfilePage> {
  late EntrepreneurDataProvider eDataProvider;
  late LoadStartupDataProvider sDataProvider;
  late GlobalKey<RefreshIndicatorState> _refreshIndicatorKey;

  @override
  void initState() {
    super.initState();
    _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
    eDataProvider = Provider.of<EntrepreneurDataProvider>(context, listen: false);
    eDataProvider.loadUserData();

    sDataProvider = Provider.of<LoadStartupDataProvider>(context, listen: false);
    sDataProvider.loadStartupData(widget.userId);
  }

  Future<void> _refreshData() async {
    await eDataProvider.loadUserData();
    await sDataProvider.loadStartupData(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    EntrepreneurDataProvider eDataProvider =
        Provider.of<EntrepreneurDataProvider>(context);
    LoadStartupDataProvider sDataProvider = 
        Provider.of<LoadStartupDataProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 30,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${eDataProvider.userData['username']}',
                    style: const TextStyle(color: Colors.white),
                  ),
                  Text(
                    '${eDataProvider.userData['name']}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Text('Edit Your Startup'),
              onTap: () {
                Navigator.push(
                  
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditstartupPage(
                      userId: '',
                      startupData: sDataProvider.startupData,
                    ),
                  ),
                ).then((value) {
                  // Print for debugging
                  print('Returned value: $value');

                  // Reload the data only if value is true
                  if (value == true) {
                    sDataProvider.loadStartupData(widget.userId);
                  }
                });
              },
            ),
            ListTile(
              title: const Text('Edit Profile Page'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditEntrepreneurDataPage(
                      userId: '',
                      userData: eDataProvider.userData,
                    ),
                  ),
                ).then((value) {
                  // Refresh the data when returning from EditProfilePage
                  if (value == true) {
                    eDataProvider.loadUserData();
                  }
                });
              },
            ),
            ListTile(
              title: const Text('Following'),
              onTap: () {
                // Handle item 2 tap
              },
            ),
             ListTile(
              title: const Text('Search'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchPage()), // SearchPage'e yönlendirme.
                );
              },
            ),
            // Add more ListTile items as needed
            const Spacer(),
            ListTile(
              title: const Text('Logout'),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refreshData,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Kullanıcı fotoğrafı ve bilgileri
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('User Data: ${eDataProvider.userData['username']}'),
                        Text('Name Surname: ${eDataProvider.userData['name']}'),
                        Text('Location: ${eDataProvider.userData['location']}'),
                        Text('Fields ${eDataProvider.userData['entrepreneurFeatures']}'),
                      ],
                    ),
                    const Spacer(),
                  ],
                ),
              ),

              // Profil Düzenle
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditEntrepreneurDataPage(
                      userId: '',
                      userData: eDataProvider.userData,
                    ),
                  ),
                ).then((value) {
                  // Refresh the data when returning from EditProfilePage
                  if (value == true) {
                    eDataProvider.loadUserData();
                  }
                });
                  },
                  child: const Text('Edit Profile'),
                ),
              ),

              DefaultTabController(
                length: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const TabBar(
                      tabs: [
                        Tab(text: 'Features'),
                        Tab(text: 'Improvements'),
                        Tab(text: 'Startup'),
                      ],
                    ),
                    Container(
                      height: 200,
                      child: TabBarView(
                        children: [
                          // Özellikler içeriği
                          Center(
                            child: Text('${eDataProvider.userData['fields']}'),
                          ),
                          // Gelişmeler içeriği
                          Center(
                            child: ElevatedButton(
                               onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ImprovementsTab(), // Yönlendirilecek sayfanın ismi
                                ),
                              );
                            },
                              child: const Text('Add Improvements'),
                            ),
                          ),
                          // Girişim içeriği
                          Center(
                            child: sDataProvider.startupData.isEmpty
                                ? Text('Initiative data is not available.')
                                : Column(
                                    children: [
                                      Text('Startup Name: ${sDataProvider.startupData['startup_name']}'),
                                      Text('Location: ${sDataProvider.startupData['location']}'),
                                      Text('Sector: ${sDataProvider.startupData['sector']}'),
                                      Text('Description: ${sDataProvider.startupData['description']}'),
                                      Text('Story: ${sDataProvider.startupData['story']}'),
                                      Text('Social Media: ${sDataProvider.startupData['social_media']}'),
                                    ],
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
