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
          nim60: 60,
        ),
      );
    });
  }

  void deleteItem(int index) {
    setState(() {
      profiles.removeAt(index);
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
            key: Key(index.toString()),
            onDismissed: (direction) {
              final deletedItem = profiles[index];
              deleteItem(index);
              Fluttertoast.showToast(msg: "${deletedItem.name} dihapus");
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
