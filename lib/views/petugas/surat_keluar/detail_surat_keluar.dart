import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:disposur/constant.dart';
import 'package:flutter/material.dart';

class DetailSuratKeluar extends StatefulWidget {
  final String documentId;
  final String title;
  final String ditujukanKepada;
  final String nomorSurat;
  final String perihalSurat;
  final String tanggalSurat;
  final String imageName;

  const DetailSuratKeluar({Key key, this.documentId, this.ditujukanKepada, this.nomorSurat, this.perihalSurat, this.tanggalSurat, this.imageName, this.title}) : super(key: key);

  @override
  _DetailSuratKeluarState createState() => _DetailSuratKeluarState();
}

class _DetailSuratKeluarState extends State<DetailSuratKeluar> {
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Detail', style: TextStyle(color: Colors.grey[800], fontSize: 20.0, fontWeight: FontWeight.bold)),
              Text(widget.title, style: TextStyle(color: Colors.grey[800], fontSize: 20.0, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _widgetFormDetail() {
     return Expanded(
            child: Container(
                padding: EdgeInsets.all(cdefaultPadding),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Ditujukan Ke :',),
                        SizedBox(width: 16.0),
                        Text(widget.ditujukanKepada,),
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
              ),
     );
  }
}