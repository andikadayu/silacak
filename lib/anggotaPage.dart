import 'package:flutter/material.dart';
import 'package:silacak/nav-drawer-anggota.dart';

class AnggotaPage extends StatelessWidget {
  AnggotaPage({required this.username});
  final String username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Anggota"),
      ),
      drawer: DrawerWidget(),
      body: Center(
          child: Text('Belajar Navigation Drawer di Flutter',
          style: TextStyle(fontSize: 20))
      ),
    );
  }
}