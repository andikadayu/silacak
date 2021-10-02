import 'package:flutter/material.dart';
import 'package:silacak/nav-drawer-user.dart';

class UserPage extends StatelessWidget {
  UserPage({required this.username});
  final String username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      drawer: DrawerWidget(),
      body: Center(
          child: Text('Belajar Navigation Drawer di Flutter',
          style: TextStyle(fontSize: 20))
      ),
    );
  }
}