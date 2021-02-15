import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:disposur/constant.dart';
import 'package:flutter/material.dart';

class DetailSM extends StatefulWidget {
  final String uid;
  final String jabatan;
  final String pengirimSurat;
  final String perihalSurat;
  final String nomorSurat;
  final String tanggalSurat;
  final String tanggalTerima;
  final String nomorAgenda;
  final String fileSurat;

  const DetailSM({Key key, this.perihalSurat, this.nomorSurat, this.tanggalSurat, this.fileSurat, this.uid, this.jabatan, this.pengirimSurat, this.tanggalTerima, this.nomorAgenda}) : super(key: key);
  
  @override
  _DetailSMState createState() => _DetailSMState();
}

class _DetailSMState extends State<DetailSM> {
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
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back), 
            onPressed: () {
              Navigator.pop(context);
            }
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
            Text('Surat Masuk', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),
             Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Surat Dari'),
                Text(widget.pengirimSurat)
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
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Diterima Tanggal'),
                Text(widget.tanggalTerima)
              ]
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Nomor Agenda'),
                Text(widget.nomorAgenda)
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
          ),
          ]
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
                stream: Firestore.instance.collection('monitoring disposisi sm').reference().orderBy('tanggal disposisi').snapshots(),
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
                                SizedBox(height: 8.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Diteruskan kepada'),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                      Text(disposisi['nama staff 1'],
                                        style:
                                            TextStyle(fontWeight: FontWeight.w500)),
                                      Text(disposisi['nama staff 2'],
                                        style:
                                            TextStyle(fontWeight: FontWeight.w500)),
                                      ],
                                    )
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