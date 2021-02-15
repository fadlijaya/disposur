import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:disposur/constant.dart';
import 'package:flutter/material.dart';

class DetailSuratMasuk extends StatefulWidget {
  final String documentId;
  final String pengirimSurat;
  final String nomorSurat;
  final String perihalSurat;
  final String tanggalSurat;
  final String diterimaTanggal;
  final String nomorAgenda;
  final String imageName;

  const DetailSuratMasuk({Key key, this.documentId, this.pengirimSurat, this.nomorSurat, this.perihalSurat, this.tanggalSurat, this.diterimaTanggal, this.nomorAgenda, this.imageName}) : super(key: key);
 
  @override
  _DetailSuratMasukState createState() => _DetailSuratMasukState();
}

class _DetailSuratMasukState extends State<DetailSuratMasuk> {
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  final Firestore firestore = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double widthScreen = mediaQueryData.size.width;
    double heightScreen = mediaQueryData.size.height;

    return Scaffold(
        key: _scaffoldState,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                width: widthScreen,
                height: heightScreen,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _widgetHeader(),
                    _widgetFormDetail(),
                  ]
                )
              )
            ],
          ),
    ));
  }

  Widget _widgetHeader(){
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: 16.0),
          Text('Detail Surat Masuk',
              style: TextStyle(color: Colors.grey[800], fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _widgetFormDetail() {
     return Expanded(
            child: Container(
                padding: EdgeInsets.all(cdefaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Surat Dari :',),
                      SizedBox(width: 16.0),
                      Text(widget.pengirimSurat,),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Nomor Surat :',),
                      SizedBox(width: 16.0),
                      Text(widget.nomorSurat),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Perihal Surat :',),
                      SizedBox(width: 16.0),
                      Text(widget.perihalSurat),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tanggal Surat :'),
                      SizedBox(width: 16.0),
                      Text(widget.tanggalSurat),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Diterima Tanggal :'),
                      SizedBox(width: 16.0),
                      Text(widget.diterimaTanggal),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Nomor Agenda :'),
                      SizedBox(width: 16.0),
                      Text(widget.nomorAgenda),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Text('File Surat :'),
                  SizedBox(height: 16.0),
                   Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(widget.imageName, width: 120.0,),
                      ],
                    ),
                ]),
              ),
     );
  }
}
