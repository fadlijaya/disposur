import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:disposur/constant.dart';
import 'package:disposur/views/petugas/monitoring_disposisi/detail_sk.dart';
import 'package:disposur/views/petugas/monitoring_disposisi/detail_sm.dart';
import 'package:flutter/material.dart';

class Disposisi extends StatefulWidget {
  final String uid;
  final String jabatan;

  const Disposisi({Key key, this.uid, this.jabatan}) : super(key: key);
  
  @override
  _DisposisiState createState() => _DisposisiState();
}

class _DisposisiState extends State<Disposisi> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double widthScreen = mediaQueryData.size.width;
    double heightScreen = mediaQueryData.size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Monitoring Disposisi'),
        centerTitle: true,
        backgroundColor: AppColor().colorTertiary,
      ),
      body: Container(
        width: widthScreen,
        height: heightScreen,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, 
        children: [
          Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance.collection('disposisi').snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView.builder(
                        padding: EdgeInsets.all(8),
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (BuildContext context, int index) {
                          DocumentSnapshot document =
                              snapshot.data.documents[index];
                          Map<String, dynamic> disposisi = document.data;
                          return GestureDetector(
                                child: Card(
                                  child: Container(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text('Nomor : '),
                                            Text(disposisi['nomor surat'],),
                                          ],
                                        ),
                                        SizedBox(height: 4.0),
                                        Row(
                                          children: [
                                            Text('Perihal : '),
                                            Text(disposisi['perihal surat'],),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  if(disposisi['ditujukan kepada'] != null) {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailSK(
                                    uid: widget.uid,
                                    jabatan: widget.jabatan,
                                    ditujukanKepada: disposisi['ditujukan kepada'],
                                    perihalSurat: disposisi['perihal surat'],
                                    nomorSurat: disposisi['nomor surat'],
                                    tanggalSurat: disposisi['tanggal surat'],
                                    fileSurat: disposisi['file surat']
                                  )));
                                  } else {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailSM(
                                    uid: widget.uid,
                                    jabatan: widget.jabatan,
                                    pengirimSurat: disposisi['pengirim surat'],
                                    perihalSurat: disposisi['perihal surat'],
                                    nomorSurat: disposisi['nomor surat'],
                                    tanggalSurat: disposisi['tanggal surat'],
                                    tanggalTerima: disposisi['diterima tanggal'],
                                    nomorAgenda: disposisi['nomor agenda'],
                                    fileSurat: disposisi['file surat']
                                  )));
                                  }
                                },
                              );
                        });
                  }))
        ]),
      ),
    );
  }
}

