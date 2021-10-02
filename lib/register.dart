import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;


class registerPage extends StatefulWidget {
  @override
  _RegisterPage createState() => _RegisterPage();
}
class _RegisterPage extends State<registerPage> {
  bool _isHidePassword = true;

  void _togglePassword(){
    setState(() {
      _isHidePassword = !_isHidePassword;
    });
  }
  TextEditingController user=new TextEditingController();
  TextEditingController pass=new TextEditingController();
  TextEditingController nama=new TextEditingController();
  TextEditingController email=new TextEditingController();

  Future<List> _register() async {
    final response = await http.post("https://silacak.pt-ckit.com/register.php", body: {
      "nama": nama.text,
      "username": user.text,
      "password": pass.text,
      "password": email.text,
    });
    var data = json.decode(response.body);
    if (data == "error"){
      setState(() {
        tampil2();
      });
    } else {
      setState(() {
        tampil();
      });
      Navigator.pushReplacementNamed(context, '/MyHomePage');
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
        return Scaffold(
      appBar: AppBar(title: Text("Daftar",style: TextStyle(fontSize: 24.0),),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.exit_to_app, color: Colors.white,size: 40,),
          onPressed: (){
            Navigator.pushReplacementNamed(context, '/MyHomePage');
          },),
        ],),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(25, 50, 25, 0),
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
                child: TextField(
                  controller: nama,
                  decoration: InputDecoration(
                    fillColor: Colors.lightGreen[40],
                    filled: true,
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.blue,
                    ),
                    prefixStyle: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.w600),
                    labelText: "Nama",
                    hintText: 'Nama Anda Anda',
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
                padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
                child: TextField(
                  controller: email,
                  decoration: InputDecoration(
                    fillColor: Colors.lightGreen[40],
                    filled: true,
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.blue,
                    ),
                    prefixStyle: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.w600),
                    labelText: "E-mail",
                    hintText: 'exemple@gmail.com',
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
                    _register();
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
      msg: "Register Berhasil !, Silahkan Login",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize:16.0);
  }
  void tampil2() {
    Fluttertoast.showToast(
      msg: "Register Gagal",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize:16.0);
  }
}