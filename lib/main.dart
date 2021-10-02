import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:silacak/adminPage.dart';
import 'package:silacak/register.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:silacak/anggotaPage.dart';
import 'package:silacak/userPage.dart';

void main() {
  runApp(const MyApp());
}

String username = '';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ptckit',
      home: MyHomePage(),
      routes: <String, WidgetBuilder>{
        '/AdminPage': (BuildContext context) => new AdminPage(
          username: username,
        ),
        '/AnggotaPage': (BuildContext context) => new AnggotaPage(
          username: username,
        ),
        '/UserPage': (BuildContext context) => new UserPage(
          username: username,
        ),
        '/MyHomePage': (BuildContext context) => new MyHomePage(),
        '/register': (BuildContext context) => new registerPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isHidePassword = true;

  void _togglePassword(){
    setState(() {
      _isHidePassword = !_isHidePassword;
    });
  }

  TextEditingController user=new TextEditingController();
  TextEditingController pass=new TextEditingController();

  Future<List> _login() async {
    final response = await http.post("https://silacak.pt-ckit.com/login.php", body: {
      "username": user.text,
      "password": pass.text,
    });
    var datauser = json.decode(response.body);
    if (datauser.length == 0){
      //Navigator.pushReplacementNamed(context, '/AdminPage');
      setState(() {
        tampil();
      });
    } else {
      if (datauser[0]['role'] == 'admin') {
        Navigator.pushReplacementNamed(context, '/AdminPage');
      } else if(datauser[0]['role'] == 'anggota'){
        Navigator.pushReplacementNamed(context, '/AnggotaPage');
      } else if (datauser[0]['role'] == 'masyarakat') {
        Navigator.pushReplacementNamed(context, '/UserPage');
      }
      setState(() {
        username = datauser[0]['username'];
      });
    }
    return datauser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(25, 50, 25, 0),
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
                child: TextField(
                  controller: user,
                  decoration: InputDecoration(
                    fillColor: Colors.lightGreen[40],
                    filled: true,
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.blue,
                    ),
                    prefixStyle: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.w600),
                    labelText: "Username",
                    hintText: 'Username Anda',
                    hintStyle: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w200),
                    labelStyle: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.w600),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                  ),
                  ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
                child: TextField(
                  controller: pass,
                  obscureText: _isHidePassword,
                  decoration: InputDecoration(
                    fillColor: Colors.lightGreen[40],
                    filled: true,
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.blue,
                    ),
                    prefixStyle: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.w600),
                    labelText: "Password",
                    hintText: 'Password Anda',
                    hintStyle: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w200),
                    labelStyle: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.w600),
                    border: OutlineInputBorder( 
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        _togglePassword();
                      },
                      child: Icon(
                        _isHidePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: _isHidePassword ? Colors.grey : Colors.blue, 
                      ),
                    ),
                    isDense: true,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: RaisedButton(
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: 20),
                  ),
                  padding: EdgeInsets.fromLTRB(60, 10, 60, 10),
                  textColor: Colors.white,
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16.0))),
                  onPressed: () {
                    _login();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: RaisedButton(
                  child: Text(
                    "Daftar",
                    style: TextStyle(fontSize: 20),
                  ),
                  padding: EdgeInsets.fromLTRB(60, 10, 60, 10),
                  textColor: Colors.white,
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16.0))),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/register');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void tampil() {
    Fluttertoast.showToast(
      msg: "Login Gagal",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize:16.0);
  }
}
