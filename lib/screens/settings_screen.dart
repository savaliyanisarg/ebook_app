import 'package:flutter/material.dart';

import 'edit_profile_screen.dart';
import 'login_screen.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: ListView(
        children: [
          ListTile(
            title: Text('Edit Profile'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => EditProfileScreen(),
              ));
            },
          ),
          ListTile(
            title: Text('Logout'),
            onTap: () {
              // Logout logic
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ));
            },
          ),
        ],
      ),
    );
  }
}
