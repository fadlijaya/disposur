import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:disposur/constant.dart';
import 'package:disposur/views/petugas/monitoring_disposisi/cetak_detail_sk.dart';
import 'package:flutter/material.dart';

class DetailSK extends StatefulWidget {
  final String uid;
  final String jabatan;
  final String ditujukanKepada;
  final String perihalSurat;
  final String nomorSurat;
  final String tanggalSurat;
  final String fileSurat;

  const DetailSK({Key key, this.ditujukanKepada, this.perihalSurat, this.nomorSurat, this.tanggalSurat, this.fileSurat, this.uid, this.jabatan}) : super(key: key);
  
  @override
  _DetailSKState createState() => _DetailSKState();
}

class _DetailSKState extends State<DetailSK> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double widthscreen = mediaQueryData.size.width;
    double heightscreen = mediaQueryData.size.height;
    return Scaffold(
      body: SafeArea(
        child: Stack(
            children: [
              Container(
                width: widthscreen,
                height: heightscreen,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [ 
                     _header(),
                     _viewSurat(),
                     _viewDisposisi(),
                  ],
                ),
              ),
            ]
          ),
      ),
    );
  }

  _header() {
    return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back), 
                onPressed: () {
                  Navigator.pop(context);
                }
              ),
             IconButton(
                icon: Icon(Icons.picture_as_pdf),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CetakDetailSK(
                                    uid: widget.uid,
                                    jabatan: widget.jabatan,
                                    ditujukanKepada: widget.ditujukanKepada,
                                    nomorSurat: widget.nomorSurat,
                                    perihalSurat: widget.perihalSurat,
                                    tanggalSurat: widget.tanggalSurat,
                                    fileSurat: widget.fileSurat,
                                  )));
                }
              ),
            ],
          ),  
        ],
      );
  }

  _viewSurat() {
    return Card(
      child: Container(
        height: 240.0,
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Text('Surat Keluar', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),
             Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Ditujukan Kepada'),
                Text(widget.ditujukanKepada)
              ]
            ),
            SizedBox(height: 8.0),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Perihal Surat'),
                Text(widget.perihalSurat)
              ]
            ),
            SizedBox(height: 8.0),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Nomor Surat'),
                Text(widget.nomorSurat)
              ]
            ),
            SizedBox(height: 8.0),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Tanggal Surat'),
                Text(widget.tanggalSurat)
              ]
            ),
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('File Surat'),
              FlatButton(
                onPressed: () => _showSurat() , 
                child: Text('Lihat Surat', style: TextStyle(color: AppColor().colorTertiary),
              ))
            ],
            )]
        ),
      ),
    );
  }

  _viewDisposisi() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Text('Isi Disposisi', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
               ],
             ),
              Divider(),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection('monitoring disposisi sk').reference().orderBy('tanggal disposisi').snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if(!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (BuildContext context, int index) {
                      DocumentSnapshot documentSnapshot = snapshot.data.documents[index];
                      Map<String, dynamic> disposisi = documentSnapshot.data;
                      return Card(
                        child: Container(
                          width: 300.0,
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Jabatan'),
                                  Text(disposisi['jabatan'], style: TextStyle(fontWeight: FontWeight.w500),),
                                ],
                              ),
                              SizedBox(height: 8.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Disposisikan ke'),
                                  Text(disposisi['disposisikan ke'],  style: TextStyle(fontWeight: FontWeight.w500)),
                                ],
                              ),
                              SizedBox(height: 8.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Keterangan'),
                                  Text(disposisi['keterangan'],  style: TextStyle(fontWeight: FontWeight.w500)),
                                ],
                              ),
                              SizedBox(height: 8.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Tanggal Disposisi'),
                                  Text(disposisi['tanggal disposisi'],  style: TextStyle(fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  );
                }
              )
            )
          ]
        ),
      ),
    );
  }

   _showSurat() {
    return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FlatButton(
                onPressed: () => Navigator.pop(context), 
                child: Icon(Icons.close)),
              Image.network(widget.fileSurat)
            ]
          )
        );
      }
    );
  }
}