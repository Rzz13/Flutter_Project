import 'package:flutter/material.dart';
import 'package:flutter_testing/models/profile.dart';
import 'package:flutter_testing/screens/edit_profile.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DetailProfile extends StatefulWidget {
  const DetailProfile({super.key, required this.profile});

  final Profile profile;

  @override
  State<DetailProfile> createState() => _DetailProfileState();
}

class _DetailProfileState extends State<DetailProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Profile'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/background1.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 110,
                    child: CircleAvatar(
                      radius: 80,
                      backgroundImage: NetworkImage(
                        "https://i.pravatar.cc/150?img=${widget.profile.id}",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              widget.profile.name,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "NIM: ${widget.profile.nim60}",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
            ),
            Text(
              widget.profile.bio,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w100),
            ),
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel sem sit amet dolor hendrerit aliquet. Praesent at mauris vel arcu cursus commodo. Donec eget tortor at elit fermentum facilisis. Nulla facilisi. Sed vel sapien id turpis pulvinar vestibulum. Integer malesuada, neque nec ullamcorper tincidunt, nisl nunc aliquet nunc, non ultricies erat elit id urna. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Suspendisse potenti. Nam auctor, sapien at vehicula placerat, odio metus suscipit elit, sed luctus magna lorem at odio. Cras ut augue non sapien tristique euismod. Morbi quis ligula nec arcu tincidunt pellentesque. Aenean ac mauris vitae purus fermentum tincidunt. Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur? At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae. Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat.",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () async {
                await Fluttertoast.showToast(msg: "Going back...");
                Navigator.pop(context, widget.profile);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: const Text('Go Back'),
            ),
            // Edit Profile Button
            ElevatedButton(
              onPressed: () async {
                final Profile? updatedProfile = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfile(profile: widget.profile),
                  ),
                );

                if (updatedProfile != null) {
                  setState(() {
                    widget.profile.name = updatedProfile.name;
                    widget.profile.bio = updatedProfile.bio;
                    widget.profile.nim60 = updatedProfile.nim60;
                  });
                }
              },
              child: const Text('Edit Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
