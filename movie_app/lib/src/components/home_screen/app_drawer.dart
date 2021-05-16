import 'package:flutter/material.dart';
import 'package:movie_mate/src/models/user.dart';
import 'package:movie_mate/src/services/authentication_service.dart';
import 'package:movie_mate/src/widgets/app_drawer_menu_item.dart';

class AppDrawer extends StatelessWidget {
  final MyUser myUser;
  const AppDrawer({this.myUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Drawer(
          semanticLabel: 'Settings',
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.black,
                      backgroundImage: NetworkImage(
                          myUser.photoURL.replaceFirst('s96', 's400')),
                      radius: 30,
                    ),
                    Text(
                      myUser.username,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  DrawerMenuItem(
                    menuItemTitle: 'Edit Profile',
                    menuItemIconData: Icons.edit_outlined,
                    menuItemFunction: () => Navigator.pop(context),
                  ),
                  // DrawerMenuItem(
                  //   menuItemTitle: 'Edit Genre Preference',
                  //   menuItemIconData: Icons.local_movies_sharp,
                  //   menuItemFunction: () => Navigator.pop(context),
                  // ),
                  // DrawerMenuItem(
                  //   menuItemTitle: 'Edit Disliked Movies',
                  //   menuItemIconData: Icons.movie_creation_outlined,
                  //   menuItemFunction: () => Navigator.pop(context),
                  // ),
                  DrawerMenuItem(
                    menuItemTitle: 'Logout',
                    menuItemIconData: Icons.exit_to_app_outlined,
                    menuItemFunction: () => AuthService().signOut(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
