import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:disposur/constant.dart';
import 'package:disposur/views/admin/surat_masuk/detail_surat_masuk.dart';
import 'package:disposur/views/petugas/surat_masuk/add_surat_masuk.dart';
import 'package:flutter/material.dart';

class SuratMasuk extends StatefulWidget {
  @override
  _SuratMasukState createState() => _SuratMasukState();
}

class _SuratMasukState extends State<SuratMasuk> {
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
          title: Text('Surat Masuk'),
          centerTitle: true,
          backgroundColor: AppColor().colorTertiary),
      body: SafeArea(
        child: Stack(
        children: <Widget>[
          _buildWidgetListFile(widthScreen, heightScreen, context)
        ],
      )),
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
                stream: firestore
                    .collection('surat masuk')
                    .orderBy('diterima tanggal')
                    .snapshots(),
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
                        Map<String, dynamic> suratmasuk = document.data;
                        return Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                title: Text(suratmasuk['pengirim surat'],
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500)),
                                subtitle: Text(suratmasuk['nomor surat'],
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500)),
                                isThreeLine: false,
                                trailing: PopupMenuButton(
                                  itemBuilder: (BuildContext context) {
                                    return List<PopupMenuEntry<String>>()
                                      ..add(PopupMenuItem<String>(
                                        value: 'detail',
                                        child: Text('Detail'),
                                      ))
                                      ..add(PopupMenuItem<String>(
                                        value: 'edit',
                                        child: Text('Edit'),
                                      ))
                                      ..add(PopupMenuItem<String>(
                                        value: 'hapus',
                                        child: Text('Hapus'),
                                      ));
                                  },
                                  onSelected: (String value) async {
                                    if (value == 'detail') {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailSuratMasuk(
                                                    documentId:
                                                        document.documentID,
                                                    pengirimSurat: suratmasuk[
                                                        'pengirim surat'],
                                                    nomorSurat: suratmasuk[
                                                        'nomor surat'],
                                                    perihalSurat: suratmasuk[
                                                        'perihal surat'],
                                                    tanggalSurat: suratmasuk[
                                                        'tanggal surat'],
                                                    diterimaTanggal: suratmasuk[
                                                        'diterima tanggal'],
                                                    nomorAgenda: suratmasuk[
                                                        'nomor agenda'],
                                                    imageName: suratmasuk[
                                                        'file surat'],
                                                  )));
                                    } else if (value == 'edit') {
                                      bool result = await Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) {
                                          return AddSuratMasuk(
                                            isEdit: true,
                                            documentId: document.documentID,
                                            pengirimSurat:
                                                suratmasuk['pengirim surat'],
                                            nomorSurat:
                                                suratmasuk['nomor surat'],
                                            perihalSurat:
                                                suratmasuk['perihal surat'],
                                            tanggalSurat:
                                                suratmasuk['tanggal surat'],
                                            diterimaTanggal:
                                                suratmasuk['diterima tanggal'],
                                            nomorAgenda:
                                                suratmasuk['nomor agenda'],
                                          );
                                        }),
                                      );
                                      if (result != null && result) {
                                        scaffoldState.currentState
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                              'Surat Masuk Telah Di Update'),
                                        ));
                                        setState(() {});
                                      }
                                    } else if (value == 'hapus') {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Konfirmasi'),
                                            content: Text(
                                                'Apa kamu ingin menghapus Surat dari ${suratmasuk['pengirim surat']}?'),
                                            actions: <Widget>[
                                              FlatButton(
                                                child: Text('Tidak'),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              FlatButton(
                                                child: Text('Hapus'),
                                                onPressed: () {
                                                  document.reference.delete();
                                                  Navigator.pop(context);
                                                  setState(() {});
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }
                                  },
                                  child: Icon(Icons.more_vert),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 16, bottom: 16),
                                child: Text(suratmasuk['perihal surat'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey)),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 16, bottom: 24),
                                child: Text(suratmasuk['diterima tanggal'],
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
