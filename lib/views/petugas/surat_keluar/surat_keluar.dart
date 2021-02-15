import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:disposur/constant.dart';
import 'package:disposur/views/petugas/surat_keluar/add_surat_keluar.dart';
import 'package:disposur/views/petugas/surat_keluar/detail_surat_keluar.dart';
import 'package:flutter/material.dart';

class SuratKeluar extends StatefulWidget {
  @override
  _SuratKeluarState createState() => _SuratKeluarState();
}

class _SuratKeluarState extends State<SuratKeluar> {
  final GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
  final Firestore firestore = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double widthScreen = mediaQueryData.size.width;
    double heightScreen = mediaQueryData.size.height;

    return Scaffold(
      key: scaffoldState,
      appBar: AppBar(
          title: Text('Surat Keluar'),
          centerTitle: true,
          backgroundColor: AppColor().colorTertiary),
      body: SafeArea(
          child: Stack(
        children: <Widget>[
          _buildWidgetListFile(widthScreen, heightScreen, context)
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool result = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddSuratKeluar(isEdit: false)));
          if (result != null && result) {
            scaffoldState.currentState.showSnackBar(SnackBar(
              content: Text('Surat Keluar Berhasil Dibuat!'),
            ));
            setState(() {});
          }
        },
        backgroundColor: AppColor().colorTertiary,
        child: Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ),
    );
  }

  Container _buildWidgetListFile(
      double widthScreen, double heightScreen, BuildContext context) {
    return Container(
      width: widthScreen,
      height: heightScreen,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
          Widget>[
        Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: firestore.collection('surat keluar').snapshots(),
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
                        Map<String, dynamic> suratkeluar = document.data;
                        return Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                title: Text(suratkeluar['ditujukan kepada'],
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500)),
                                subtitle: Text(suratkeluar['nomor surat'],
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500)),
                                isThreeLine: false,
                                trailing: PopupMenuButton(
                                  itemBuilder: (BuildContext context) {
                                    return List<PopupMenuEntry<String>>()
                                      ..add(PopupMenuItem<String>(
                                        value: 'detail',
                                        child: Text('Detail'),
                                      ));
                                  },
                                  onSelected: (String value) async {
                                    if (value == 'detail') {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailSuratKeluar(
                                                    documentId:document.documentID,
                                                    ditujukanKepada:
                                                        suratkeluar[
                                                            'ditujukan kepada'],
                                                    nomorSurat: suratkeluar[
                                                        'nomor surat'],
                                                    perihalSurat: suratkeluar[
                                                        'perihal surat'],
                                                    tanggalSurat: suratkeluar[
                                                        'tanggal surat'],
                                                    imageName: suratkeluar[
                                                        'file surat'],
                                                  )));
                                    }
                                  },
                                  child: Icon(Icons.more_vert),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 16, bottom: 16),
                                child: Text(suratkeluar['perihal surat'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey)),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 16, bottom: 24),
                                child: Text(suratkeluar['tanggal surat'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey)),
                              ),
                            ],
                          ),
                        );
                      });
                }))
      ]),
    );
  }
}
