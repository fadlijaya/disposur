import 'package:disposur/constant.dart';
import 'package:disposur/views/pegawai/disposisi_saya/disposisi.dart';
import 'package:disposur/views/login.dart';
import 'package:flutter/material.dart';

class PegawaiHome extends StatefulWidget {
  final String uid;
  final String namaLengkap;
  final String email;
  final String nip;
  final String jabatan;

  const PegawaiHome({Key key, this.uid, this.namaLengkap, this.email, this.nip, this.jabatan}) : super(key: key);
  @override
  _PegawaiHomeState createState() => _PegawaiHomeState();
}

class _PegawaiHomeState extends State<PegawaiHome> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double widthscreen = mediaQueryData.size.width;
    double heightscreen = mediaQueryData.size.height;

    return Scaffold(
      body: Container(
        width: widthscreen,
        height: heightscreen,
        child: Stack(children: <Widget>[
        Container(
          height: 200.0,
          decoration: BoxDecoration(
            color: AppColor().colorTertiary,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 48.0, left: cdefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/logo/logo.png', width: 120.0),
              SizedBox(height: 4.0),
              Text(widget.namaLengkap,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white)),
              SizedBox(height: 4.0),
                Text(widget.email,
                      style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.white)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 140.0),
          child: GridView.count(
            crossAxisCount: 1,
            mainAxisSpacing: 12.0,
            childAspectRatio: 3.8,
            padding: EdgeInsets.all(cdefaultPadding),
            children: [
              GestureDetector(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: cdefaultPadding, horizontal: 24.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.note,
                          size: 48.0,
                          color: AppColor().colorTertiary,
                        ),
                        Text(
                          'Disposisi',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        )
                      ]),
                ),
                onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Disposisi(
                      uid: widget.uid,
                      jabatan: widget.jabatan
                  )));
                },
              ),
              GestureDetector(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: cdefaultPadding, horizontal: 24.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.exit_to_app, size: 48.0, color: AppColor().colorTertiary),
                        Text(
                          'Keluar',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        )
                      ]),
                ),
                onTap: () {
                  Navigator.pushReplacementNamed(context, Login.routeName);
                },
              ),
            ],
          ),
        ),
    ]),
      ));
  }
}