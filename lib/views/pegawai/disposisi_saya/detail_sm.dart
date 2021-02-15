import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:disposur/constant.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  const DetailSM(
      {Key key,
      this.perihalSurat,
      this.nomorSurat,
      this.tanggalSurat,
      this.fileSurat,
      this.uid,
      this.jabatan,
      this.pengirimSurat,
      this.tanggalTerima,
      this.nomorAgenda})
      : super(key: key);

  @override
  _DetailSMState createState() => _DetailSMState();
}

class _DetailSMState extends State<DetailSM> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _tanggalDisposisi = TextEditingController();
  TextEditingController _keterangan = TextEditingController();
  TextEditingController _namaStaff1 = TextEditingController();
  TextEditingController _namaStaff2 = TextEditingController();

  DateTime date = DateTime.now();
  var _selectedJabatan;

  List<String> _listJabatan = <String>[
    'Petugas',
    'Kasubag Tata Usaha',
    'Kabag Umum',
    'Sekretaris Dewan',
    'Pimpinan'
  ];

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double widthscreen = mediaQueryData.size.width;
    double heightscreen = mediaQueryData.size.height;

    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          Container(
            width: widthscreen,
            height: heightscreen,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _header(),
                _viewSurat(),
                _viewDisposisi(),
                Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        color: Colors.white,
                        child: RaisedButton(
                          color: AppColor().colorTertiary,
                          textColor: Colors.white,
                          onPressed: () {
                            _showInputDisposisi();
                          },
                          child: Text('Disposisi'),
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ]),
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
            }),
      ],
    );
  }

  _viewSurat() {
    return Card(
      child: Container(
        height: 240.0,
        padding: EdgeInsets.all(8.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            'Surat Masuk',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
          ),
          Divider(),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text('Surat Dari'), Text(widget.pengirimSurat)]),
          SizedBox(height: 8.0),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text('Perihal Surat'), Text(widget.perihalSurat)]),
          SizedBox(height: 8.0),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text('Nomor Surat'), Text(widget.nomorSurat)]),
          SizedBox(height: 8.0),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text('Tanggal Surat'), Text(widget.tanggalSurat)]),
          SizedBox(height: 8.0),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text('Diterima Tanggal'), Text(widget.tanggalTerima)]),
          SizedBox(height: 8.0),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text('Nomor Agenda'), Text(widget.nomorAgenda)]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('File Surat'),
              FlatButton(
                  onPressed: () => _showSurat(),
                  child: Text(
                    'Lihat Surat',
                    style: TextStyle(color: AppColor().colorTertiary),
                  ))
            ],
          ),
        ]),
      ),
    );
  }

  _viewDisposisi() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Isi Disposisi',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
            ],
          ),
          Divider(),
          Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance
                      .collection('monitoring disposisi sm')
                      .reference()
                      .orderBy('tanggal disposisi')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView.builder(
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (BuildContext context, int index) {
                          DocumentSnapshot documentSnapshot =
                              snapshot.data.documents[index];
                          Map<String, dynamic> disposisi =
                              documentSnapshot.data;
                          return Card(
                            child: Container(
                              width: 300.0,
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Jabatan'),
                                      Text(
                                        disposisi['jabatan'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8.0),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Disposisikan ke'),
                                      Text(disposisi['disposisikan ke'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                  SizedBox(height: 8.0),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Keterangan'),
                                      Text(disposisi['keterangan'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                  SizedBox(height: 8.0),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Tanggal Disposisi'),
                                      Text(disposisi['tanggal disposisi'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                  SizedBox(height: 8.0),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Diteruskan kepada'),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(disposisi['nama staff 1'],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500)),
                                          Text(disposisi['nama staff 2'],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500)),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  })),
        ]),
      ),
    );
  }

  _showInputDisposisi() {
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0))),
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          icon: Icon(Icons.close, color: Colors.grey),
                          onPressed: () {
                            Navigator.pop(context);
                            _tanggalDisposisi.clear();
                            _keterangan.clear();
                          }),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                    child: Column(
                      children: [
                        Text(
                          widget.jabatan,
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        DropdownButton(
                          items: _listJabatan
                              .map((value) => DropdownMenuItem(
                                    child: Text(value),
                                    value: value,
                                  ))
                              .toList(),
                          onChanged: (selected) {
                            setState(() {
                              _selectedJabatan = selected;
                            });
                          },
                          value: _selectedJabatan,
                          isExpanded: true,
                          hint: Text('Disposisikan ke'),
                        ),
                        TextFormField(
                          controller: _keterangan,
                          decoration: InputDecoration(labelText: 'Keterangan'),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Keterangan Tidak Boleh Kosong';
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            _keterangan.text = value;
                          },
                        ),
                        TextFormField(
                          controller: _tanggalDisposisi,
                          decoration: InputDecoration(
                            labelText: 'Tanggal Disposisi',
                            suffixIcon: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Icon(Icons.today),
                              ],
                            ),
                          ),
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
                              _tanggalDisposisi.text =
                                  DateFormat('dd MMMM yyyy').format(date);
                            }
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Tanggal Tidak Boleh Kosong';
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            _tanggalDisposisi.text = value;
                          },
                        ),
                        SizedBox(height: 16.0),
                        Row(
                          children: [
                            Text('Diteruskan Kepada :'),
                          ],
                        ),
                        TextFormField(
                          controller: _namaStaff1,
                          decoration:
                              InputDecoration(labelText: 'Nama Staff 1'),
                        ),
                        TextFormField(
                          controller: _namaStaff2,
                          decoration:
                              InputDecoration(labelText: 'Nama Staff 2'),
                        ),
                        SizedBox(height: 8.0),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    color: Colors.white,
                    child: RaisedButton(
                      color: AppColor().colorTertiary,
                      textColor: Colors.white,
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          CollectionReference collectionReference = Firestore
                              .instance
                              .collection('monitoring disposisi sm')
                              .reference();
                          DocumentReference documentReference =
                              await collectionReference.add(<String, dynamic>{
                            'pengirim surat': widget.pengirimSurat,
                            'perihal surat': widget.perihalSurat,
                            'nomor surat': widget.nomorSurat,
                            'tanggal surat': widget.tanggalSurat,
                            'tanggal terima': widget.tanggalTerima,
                            'nomor agenda': widget.nomorAgenda,
                            'file surat': widget.fileSurat,
                            'jabatan': widget.jabatan,
                            'keterangan': _keterangan.text,
                            'tanggal disposisi': _tanggalDisposisi.text,
                            'disposisikan ke': _selectedJabatan,
                            'nama staff 1': _namaStaff1.text,
                            'nama staff 2': _namaStaff2.text
                          });
                          if (documentReference.documentID != null) {
                            Navigator.pop(context);
                            _tanggalDisposisi.clear();
                            _keterangan.clear();
                          }
                        }
                      },
                      child: Text('Submit'),
                    ),
                  ),
                ]),
          );
        });
  }

  _showSurat() {
    return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
              content: Column(mainAxisSize: MainAxisSize.min, children: [
            FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Icon(Icons.close)),
            Image.network(widget.fileSurat)
          ]));
        });
  }
}
