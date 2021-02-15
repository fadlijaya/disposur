import 'dart:ui';

import 'package:disposur/constant.dart';
import 'package:disposur/views/login.dart';
import 'package:disposur/views/petugas/monitoring_disposisi/disposisi.dart';
import 'package:disposur/views/petugas/surat_keluar/surat_keluar.dart';
import 'package:flutter/material.dart';
import 'package:disposur/views/petugas/surat_masuk/surat_masuk.dart';

class PetugasHome extends StatefulWidget {
  final String uid;
  final String namaLengkap;
  final String jabatan;
  final String nip;
  final String email;

  const PetugasHome(
      {Key key, this.uid, this.namaLengkap, this.jabatan, this.nip, this.email})
      : super(key: key);

  @override
  _PetugasHomeState createState() => _PetugasHomeState();
}

class _PetugasHomeState extends State<PetugasHome> {
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
                              fontWeight: FontWeight.w500, color: Colors.white)),
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
                            Icon(Icons.email,
                                size: 48.0, color: AppColor().colorTertiary),
                            Text(
                              'Surat Masuk',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            )
                          ]),
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SuratMasuk()));
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
                            Icon(Icons.mark_email_unread,
                                size: 48.0, color: AppColor().colorTertiary),
                            Text(
                              'Surat Keluar',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            )
                          ]),
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SuratKeluar()));
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
                            Icon(Icons.note,
                                size: 48.0, color: AppColor().colorTertiary),
                            Text(
                              'Monitoring Disposisi',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            )
                          ]),
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Disposisi()));
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
                            Icon(Icons.exit_to_app,
                                size: 48.0, color: AppColor().colorTertiary),
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
