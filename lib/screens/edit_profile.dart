import 'package:flutter/material.dart';
import 'package:flutter_testing/models/profile.dart';
import 'package:flutter_testing/provider/profile_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key, required this.id});

  final int id;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _bioController;
  late TextEditingController _nimController;
  late TextEditingController _coverPhotoController;
  late TextEditingController _profilePhotoController;

  @override
  void initState() {
    super.initState();

    final provider = context.read<ProfileProvider>();
    final profile = provider.getById(widget.id);

    _nameController = TextEditingController(text: profile?.name);
    _bioController = TextEditingController(text: profile?.bio);
    _nimController = TextEditingController(text: profile?.nim60.toString());
    _coverPhotoController = TextEditingController(text: profile?.coverPhoto);
    _profilePhotoController = TextEditingController(
      text: profile?.profilePhoto,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    _nimController.dispose();
    _coverPhotoController.dispose();
    _profilePhotoController.dispose();
    super.dispose();
  }

  Future<void> pickCoverPhoto(ImageSource source) async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      setState(() {
        _coverPhotoController.text = image.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                  ),
                  TextFormField(
                    controller: _bioController,
                    decoration: const InputDecoration(labelText: 'Bio'),
                  ),
                  TextFormField(
                    controller: _nimController,
                    decoration: const InputDecoration(labelText: 'NIM'),
                    keyboardType: TextInputType.number,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final updatedProfile = Profile(
                          id: widget.id,
                          name: _nameController.text,
                          bio: _bioController.text,
                          nim60: int.parse(_nimController.text),
                          coverPhoto: _coverPhotoController.text,
                          profilePhoto: _profilePhotoController.text,
                        );
                        Fluttertoast.showToast(
                          msg: "Profile updated successfully",
                        );
                        Navigator.pop(context, updatedProfile);
                      }
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
