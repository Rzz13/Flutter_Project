import 'package:flutter/material.dart';
import 'package:flutter_testing/screens/detail_profile.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_testing/models/profile.dart';

class ListProfile extends StatefulWidget {
  const ListProfile({super.key});

  @override
  State<ListProfile> createState() => _ListProfileState();
}

class _ListProfileState extends State<ListProfile> {
  List<Profile> profiles = [];
  void addProfile() {
    setState(() {
      int lastIndex = profiles.length;
      profiles.add(
        Profile(
          id: lastIndex + 1,
          name: "Muhamad Rizqi ${lastIndex + 1}",
          bio: "Flutter Developer",
          nim60: 60 + lastIndex + 1,
        ),
      );
    });
  }

  void deleteItem(int id) {
    setState(() {
      profiles.removeWhere((profile) => profile.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('List Profile')),
      body: ListView.builder(
        itemCount: profiles.length,
        itemBuilder: (context, index) {
          final profile = profiles[index];
          return Dismissible(
            key: Key(profile.id.toString()),
            onDismissed: (direction) {
              deleteItem(profile.id);
              Fluttertoast.showToast(msg: "${profile.name} dihapus");
            },
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                  "https://i.pravatar.cc/150?img=${index + 1}",
                ),
              ),
              title: Text(profile.name),
              subtitle: Text(profile.bio),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailProfile(profile: profile),
                ),
              ),
            ),
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
