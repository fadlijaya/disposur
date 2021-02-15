import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:disposur/constant.dart';
import 'package:disposur/views/admin/admin_home.dart';
import 'package:disposur/views/petugas/petugas_home.dart';
import 'package:disposur/views/pegawai/pegawai_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  static const routeName = '/login';
  
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _isHidePassword = true;

  void _togglePasswordVisibility() {
    setState(() {
      _isHidePassword = !_isHidePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().colorTertiary,
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Padding(
              padding: EdgeInsets.only(top: 72, left: 72, right: 72),
              child: Image.asset('assets/logo/logo.png')),
          SizedBox(height: 8),
          Text(
            'DISPOSISI SURAT',
            style: TextStyle(
                fontWeight: FontWeight.w500, fontSize: 16, color: Colors.white),
          ),
          Text(
            'Kantor Sekretariat DPRD Kota Makassar',
            style: TextStyle(
                fontWeight: FontWeight.w500, fontSize: 16, color: Colors.white),
          ),
          SizedBox(height: 48),
          Card(
            margin: EdgeInsets.all(cdefaultPadding),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(cdefaultPadding),
              child: Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      hintStyle: TextStyle(color: AppColor().colorTertiary),
                      enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColor().colorTertiary)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColor().colorTertiary)),
                      border: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColor().colorTertiary)),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: TextStyle(color: AppColor().colorTertiary),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColor().colorTertiary),
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColor().colorTertiary)),
                      border: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColor().colorTertiary)),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          _togglePasswordVisibility();
                        },
                        child: Icon(
                            _isHidePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: _isHidePassword
                                ? Colors.grey
                                : AppColor().colorTertiary),
                      ),
                    ),
                    obscureText: _isHidePassword,
                  ),
                  SizedBox(height: 24),
                  ButtonTheme(
                    minWidth: 330,
                    height: 48,
                    child: RaisedButton(
                      onPressed: logIn,
                      color: AppColor().colorTertiary,
                      child: Container(
                        margin: EdgeInsets.only(
                            left: cdefaultPadding, right: cdefaultPadding),
                        child: Text(
                          'LOGIN',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  void logIn() async {
    if (_formKey.currentState.validate()) {
      dynamic result =  await _auth.signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
          

      FirebaseUser user = await FirebaseAuth.instance.currentUser();

      if (result == null) {
        return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text('Email Tidak Ditemukan'),
                actions: [
                  FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Tutup'))
                ],
              );
            });
      } else if (user.uid == "dIywRZnDP5Meo23kJTlylLLnduq2") {
        var user = await FirebaseAuth.instance.currentUser();
          Firestore.instance
            .collection('admin')
            .document(user.uid)
            .get()
            .then((result) => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AdminHome(
                        uid: user.uid,
                        namaLengkap: result['nama lengkap'],
                        email: result['email'],
                        nip: result['nip'],
                        jabatan: result['jabatan']))));
      } else if (user.uid == 'RHt0D9vjOAVyT2D5EXTA9PBBEug1') {
        var user = await FirebaseAuth.instance.currentUser();
          Firestore.instance
            .collection('petugas')
            .document(user.uid)
            .get()
            .then((result) => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PetugasHome(
                        uid: user.uid,
                        namaLengkap: result['nama lengkap'],
                        email: result['email'],
                        nip: result['nip'],
                        jabatan: result['jabatan']))));  
      } else {
        FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: _emailController.text,
                password: _passwordController.text)
            .then((currentUser) => Firestore.instance
                .collection('pegawai')
                .document(currentUser.user.uid)
                .get()
                .then((DocumentSnapshot result) => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PegawaiHome(
                            uid: currentUser.user.uid,
                            namaLengkap: result['nama lengkap'],
                            email: result['email'],
                            nip: result['nip'],
                            jabatan: result['jabatan']))))
                .catchError((err) => print(err)))
            .catchError((err) => print(err));
      }
    }
  }
}
