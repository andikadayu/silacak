import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _drawerHeader(),
          _drawerItem(
              icon: Icons.location_pin,
              text: 'Lokasi Saya',
              onTap: () => print('Tap My Files')),
          _drawerItem(
              icon: Icons.location_pin,
              text: 'Lokasi Anggota',
              onTap: () => print('Tap Shared menu')),
          _drawerItem(
              icon: Icons.message,
              text: 'Pesan',
              onTap: () => print('Tap Recent menu')),
          _drawerItem(
              icon: Icons.list,
              text: 'List Anggota',
              onTap: () => print('Tap Recent menu')),
          _drawerItem(
              icon: Icons.list,
              text: 'List User',
              onTap: () => print('Tap Recent menu')),
          _drawerItem(
              icon: Icons.exit_to_app,
              text: 'Keluar',
              onTap: () => Navigator.pushReplacementNamed(context, '/MyHomePage')),
          Divider(height: 25, thickness: 1),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 10, bottom: 10),
            child: Text("Labels",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                )),
          ),
          _drawerItem(
              icon: Icons.bookmark,
              text: 'Family',
              onTap: () => print('Tap Family menu')),
        ],
      ),
    );
  }
}

Widget _drawerHeader() {
  return UserAccountsDrawerHeader(
    currentAccountPicture: ClipOval(
      child: Image(
          image: AssetImage('assets/images/orang2.jpeg'), fit: BoxFit.cover),
    ),
    accountName: Text('Admin'),
    accountEmail: Text('admin@admin.com'),
  );
}

Widget _drawerItem({required IconData icon, required String text, required GestureTapCallback onTap}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Icon(icon),
        Padding(
          padding: EdgeInsets.only(left: 25.0),
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
    onTap: onTap,
  );
}