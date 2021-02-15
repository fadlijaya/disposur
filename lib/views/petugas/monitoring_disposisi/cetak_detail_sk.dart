import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class CetakDetailSK extends StatefulWidget {
  final String uid;
  final String jabatan;
  final String ditujukanKepada;
  final String perihalSurat;
  final String nomorSurat;
  final String tanggalSurat;
  final String fileSurat;

  CetakDetailSK(
      {Key key,
      this.uid,
      this.jabatan,
      this.ditujukanKepada,
      this.perihalSurat,
      this.nomorSurat,
      this.tanggalSurat,
      this.fileSurat})
      : super(key: key);

  @override
  _CetakDetailSKState createState() => _CetakDetailSKState();
}

class _CetakDetailSKState extends State<CetakDetailSK> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PdfPreview(build: (format) => _generatePdf(format)),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format) async {
    final pdf = pw.Document();

    var dataList = await _getData();

    pdf.addPage(pw.Page(
        pageFormat: format,
        build: (context) {
          return pw.Container(
              child: pw.Column(children: [
            _header(),
            _viewSurat(),
            _viewDisposisi(dataList),
          ]));
        }));
    return pdf.save();
  }

  _header() {
    return pw.Container(
      child:
          pw.Column(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
        pw.Text('SEKRETARIAT DEWAN PERWAKILAN RAKYAT DAERAH',
            style:
                pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 14.0)),
        pw.SizedBox(height: 8.0),
        pw.Text('KOTA MAKASSAR',
            style:
                pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 20.0)),
        pw.SizedBox(height: 16.0),
         pw.Text('Lembar Disposisi',
            style:
                pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 16.0)),
        pw.SizedBox(height: 8.0),
        pw.Divider()
      ]),
    );
  }

  _viewSurat() {
    return pw.Container(
        child: pw
            .Column(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
      pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
        pw.Text('Ditujukan ke :'),
        pw.Text(widget.ditujukanKepada),
        pw.Text('Tanggal Surat :'),
        pw.Text(widget.tanggalSurat)
      ]),
      pw.Divider(),
      pw.SizedBox(height: 4.0),
      pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
        pw.Text('Perihal Surat :'),
        pw.Text(widget.perihalSurat),
        pw.Text('Nomor Surat :'),
        pw.Text(widget.nomorSurat),
      ]),
      pw.Divider(),
      pw.SizedBox(height: 8.0),
    ]));
  }

  _viewDisposisi(List _listData) {
    return pw.Container(
      child: pw.Column(
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
            pw.Text('Isi Disposisi',
                style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold, fontSize: 16.0)),
          ]),
          pw.SizedBox(height: 8.0),
          pw.ListView.builder(
                      itemCount: _listData.length,
                      itemBuilder: (_, index) {
                        DocumentSnapshot documentSnapshot = _listData[index];
                        Map<String, dynamic> disposisi = documentSnapshot.data;
                        return pw.Container(
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Row(
                                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                children: [
                                  pw.Text(disposisi['jabatan'],),
                                  pw.Text(disposisi['keterangan'],),
                                  pw.Text(disposisi['tanggal disposisi'],),
                                ],
                              ),
                               pw.SizedBox(height: 4.0),
                              pw.Row(
                                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                children: [
                                  pw.Text('Disposisikan ke :'),
                                  pw.Text(disposisi['disposisikan ke'],),
                                ],
                              ),
                              pw.Divider()
                            ],
                          ),
                        );

                      })
        ],
      ),
    );
  }

  _getData() async {
    var db = Firestore.instance.collection('monitoring disposisi sk').orderBy('tanggal disposisi');

    var document = await db.getDocuments();

    return document.documents;

  }
}
