import 'package:flutter/material.dart';
import 'package:flutter_testing/provider/profile_provider.dart';
import 'package:flutter_testing/screens/detail_profile.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_testing/models/profile.dart';
import 'package:provider/provider.dart';

class ListProfile extends StatefulWidget {
  const ListProfile({super.key});

  @override
  State<ListProfile> createState() => _ListProfileState();
}

class _ListProfileState extends State<ListProfile> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileProvider>().fetchProfiles();
    });
  }

  List<Profile> profiles = [];

  int counter = 0;

  void addProfile() {
    final provider = context.read<ProfileProvider>();
    int currentCount = provider.profiles.length;

    int rand = (currentCount + 1) % 2 + 1;
    final newProfile = Profile(
      name: "Muhamad Rizqi ${currentCount + 1}",
      bio: "Flutter Developer",
      nim60: 138492 + currentCount + 1,
      coverPhoto: "assets/images/background$rand.jpg",
      profilePhoto: "https://picsum.photos/200/300?random=${currentCount + 1}",
    );
    provider.addProfile(newProfile);
  }

  void deleteItem(int id) {
    context.read<ProfileProvider>().deleteProfile(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('List Profile')),
      body: Consumer<ProfileProvider>(
        builder: (context, profileProvider, child) {
          final profiles = profileProvider.profiles;
          return ListView.builder(
            itemCount: profiles.length,
            itemBuilder: (context, index) {
              final profile = profiles[index];
              return Dismissible(
                key: Key(profile.id.toString()),
                onDismissed: (direction) {
                  final deletedItem = profile;
                  deleteItem(profile.id!);
                  Fluttertoast.showToast(
                    msg: "Profile ${deletedItem.name} dihapus",
                  );
                },
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(profile.profilePhoto),
                  ),
                  title: Text(profile.name),
                  subtitle: Text(profile.bio),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DetailProfile(profileId: profile.id!),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addProfile();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
