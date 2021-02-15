import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:disposur/constant.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddSuratKeluar extends StatefulWidget {
  final bool isEdit;
  final String documentId;
  final String ditujukanKepada;
  final String nomorSurat;
  final String perihalSurat;
  final String tanggalSurat;
  final String imageName;

  const AddSuratKeluar(
      {Key key,
      this.isEdit,
      this.documentId = '',
      this.ditujukanKepada = '',
      this.nomorSurat = '',
      this.perihalSurat = '',
      this.tanggalSurat = '', 
      this.imageName = '', })
      : super(key: key);

  @override
  _AddSuratKeluarState createState() => _AddSuratKeluarState();
}

class _AddSuratKeluarState extends State<AddSuratKeluar> {
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  final Firestore firestore = Firestore.instance;

  final TextEditingController _ditujukanKepada = TextEditingController();
  final TextEditingController _nomorSurat = TextEditingController();
  final TextEditingController _perihalSurat = TextEditingController();
  final TextEditingController _tanggalSurat = TextEditingController();

  bool isLoading = false;
  DateTime date = DateTime.now();

  File sampleImage;

  @override
  void initState() {
    if (widget.isEdit) {
      _ditujukanKepada.text = widget.ditujukanKepada;
      _nomorSurat.text = widget.nomorSurat;
      _perihalSurat.text = widget.perihalSurat;
      _tanggalSurat.text = widget.tanggalSurat;
    } 
    super.initState();
  }

  String _imageUrl;

   Future uploadImage() async {
    var _storage = FirebaseStorage.instance;
 
    final _picker = ImagePicker();
    PickedFile image;

    image = await _picker.getImage(source: ImageSource.gallery);
    var file = File(image.path);

    if (image != null) {
      var snapshot = await _storage
          .ref()
          .child('surat keluar/$image')
          .putFile(file)
          .onComplete;

      var downloadUrl = await snapshot.ref.getDownloadURL();

      setState(() {
        _imageUrl = downloadUrl;
      });
    } else {
      print('No Print Received');
    }
  }

  @override
  Widget build(BuildContext context) {
  MediaQueryData mediaQueryData = MediaQuery.of(context);
    double widthScreen = mediaQueryData.size.width;
    double heightScreen = mediaQueryData.size.height;

    return Scaffold(
      key: _scaffoldState,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Stack(children: <Widget>[
        Container(
          width: widthScreen,
          height: heightScreen,
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _widgetForm1(), 
            _widgetForm2(),
              isLoading
                      ? Container(
                          color: Colors.white,
                          padding: const EdgeInsets.all(16.0),
                          child: Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(AppColor().colorTertiary),
                            ),
                          ),
                        )
                      : _widgetButton(),
          ],
        ))
      ])),
    );
  }

  Widget _widgetForm1() {
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
          Text(widget.isEdit ? 'Edit\nSurat Keluar' : 'Buat\nSurat Keluar',
              style: TextStyle(color: Colors.grey[800], fontSize: 20.0, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _widgetForm2() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(cdefaultPadding),
        child: Column(
          children: [
            TextFormField(
              controller: _ditujukanKepada,
              decoration: InputDecoration(labelText: 'Ditujukan Kepada'),
            ),
            TextFormField(
              controller: _nomorSurat,
              decoration: InputDecoration(labelText: 'Nomor Surat'),
            ),
            TextFormField(
              controller: _perihalSurat,
              decoration: InputDecoration(labelText: 'Perihal Surat'),
            ),
            TextFormField(
              controller: _tanggalSurat,
              decoration: InputDecoration(
                  labelText: 'Tanggal Surat',
                  suffixIcon: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[Icon(Icons.today)])),
              readOnly: true,
              onTap: () async {
                DateTime today = DateTime.now();
                DateTime datePicker = await showDatePicker(
                  context: context,
                  initialDate: date,
                  firstDate: DateTime(2000),
                  lastDate: today,
                );
                if (datePicker != null) {
                  date = datePicker;
                  _tanggalSurat.text = DateFormat('dd MMMM yyyy').format(date);
                }
              },
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text('Upload Foto/Scan Surat Keluar (File .JPG)'),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                (_imageUrl != null) ? Image.network(_imageUrl, height: 60.0) : Text(''),
                    FlatButton(
                onPressed: uploadImage,
                child: Container(
                    width: 90,
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 4,
                              offset: Offset(0, 2))
                        ]),
                    child: Center(
                        child: Text('Upload',
                            style: TextStyle(
                              color: AppColor().colorTertiary,
                            ))))),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _widgetButton() {
    return Container(
      width: double.infinity,
      height: 60,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: RaisedButton(
        color: AppColor().colorTertiary,
        child: Text(widget.isEdit ? 'EDIT' : 'SIMPAN'),
        textColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        onPressed: () async {
          String ditujukanKepada = _ditujukanKepada.text;
          String nomorSurat = _nomorSurat.text;
          String perihalSurat = _perihalSurat.text;
          String tanggalSurat = _tanggalSurat.text;
          String imageName = _imageUrl;
         
          if (ditujukanKepada.isEmpty) {
            _showSnackBarMessage('Invalid Tujuan Surat');
            return;
          } else if (nomorSurat.isEmpty) {
            _showSnackBarMessage('Invalid Nomor Surat');
            return;
          } else if (perihalSurat.isEmpty) {
            _showSnackBarMessage('Invalid Perihal Surat');
            return;
          } else if (tanggalSurat.isEmpty) {
            _showSnackBarMessage('Invalid Tanggal Surat');
            return;
          } else if (imageName.isEmpty) {
            _showSnackBarMessage('Invalid File Surat');
            return;
          }

          setState(() => isLoading = true);
          if (widget.isEdit) {
            DocumentReference documentReference = firestore.document('surat keluar/${widget.documentId}');
            firestore.runTransaction((transaction) async {
              DocumentSnapshot documentSnapshot = await transaction.get(documentReference);
              if (documentSnapshot.exists) {
                await transaction.update(
                  documentReference,
                  <String, dynamic>{
                    'ditujukan kepada': ditujukanKepada,
                    'nomor surat': nomorSurat,
                    'perihal surat': perihalSurat,
                    'tanggal surat': tanggalSurat,
                    'file surat': imageName,
                  },
                );
                Navigator.pop(context, true);
              }
            });
          } else {
            Firestore.instance.collection('surat keluar').add(<String, dynamic>{
              'ditujukan kepada': ditujukanKepada,
              'nomor surat': nomorSurat,
              'perihal surat': perihalSurat,
              'tanggal surat': tanggalSurat,
              'file surat': imageName,
            });

            DocumentReference documentReferenceD = Firestore.instance.collection('disposisi').document();
            documentReferenceD.setData({
              'ditujukan kepada': ditujukanKepada,
              'nomor surat': nomorSurat,
              'perihal surat': perihalSurat,
              'tanggal surat': tanggalSurat,
              'file surat': imageName,
            });
            if(documentReferenceD.documentID != null) {
              Navigator.pop(context, true);
            }
          }
        },
      ),
    );
  }

  void _showSnackBarMessage(String message) {
    _scaffoldState.currentState.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
}
