import 'package:disposur/constant.dart';
import 'package:flutter/material.dart';

class Akun extends StatefulWidget {
  final String uid;
  final String namaLengkap;
  final String email;
  final String nip;
  final String jabatan;

  const Akun(
      {Key key, this.uid, this.namaLengkap, this.email, this.nip, this.jabatan})
      : super(key: key);

  @override
  _AkunState createState() => _AkunState();
}

class _AkunState extends State<Akun> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double widthScreen = mediaQueryData.size.width;
    double heightScreen = mediaQueryData.size.height;

    return Scaffold(
      body: Stack(
      children: [
        Container(
          width: widthScreen,
          height: heightScreen,
          child: Column(children: [
            _widgetHeader(),
            _widgetDetail()
          ]),
        ),
      ],
    ));
  }

  Widget _widgetHeader() {
    return Container(
      height: 200.0,
      decoration: BoxDecoration(
        color: AppColor().colorTertiary,
      ),
      child: Center(
        child: CircleAvatar(
            maxRadius: 40.0,
            backgroundColor: Colors.white,
            child: Image.asset(
              'assets/avatar.png',
              width: 64.0,
              height: 64.0,
            )),
      ),
    );
  }

  Widget _widgetDetail() {
    return Expanded(
          child: Container(
            child: ListView(
              children: [
                ListTile(
                  title: Text(
                    'NIP',
                    style: TextStyle(fontSize: 14.0),
                  ),
                  subtitle: Text(widget.nip),
                ),
                Divider(height: 1),
                ListTile(
                  title: Text(
                    'Nama Lengkap',
                    style: TextStyle(fontSize: 14.0),
                  ),
                  subtitle: Text(widget.namaLengkap),
                ),
                Divider(height: 1),
                ListTile(
                  title: Text(
                    'Jabatan',
                    style: TextStyle(fontSize: 14.0),
                  ),
                  subtitle: Text(widget.jabatan),
                ),
                Divider(height: 1),
                ListTile(
                  title: Text(
                    'Email',
                    style: TextStyle(fontSize: 14.0),
                  ),
                  subtitle: Text(widget.email),
                ),
                Divider(height: 1),
              ],
            ),
          ),
    );
  }
}
