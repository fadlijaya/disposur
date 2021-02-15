import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:disposur/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AkunPetugas extends StatefulWidget {
  @override
  _AkunPetugasState createState() => _AkunPetugasState();
}

class _AkunPetugasState extends State<AkunPetugas> {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _namaLengkap = TextEditingController();
  final TextEditingController _jabatan = TextEditingController();
  final TextEditingController _nip = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double widthScreen = mediaQueryData.size.width;
    double heightScreen = mediaQueryData.size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Akun Petugas'),
        centerTitle: true,
        backgroundColor: AppColor().colorTertiary,
        actions: [
          IconButton(icon: Icon(
            Icons.add_box, 
            color: Colors.white),
            onPressed: () => addAkun())
        ],
      ),
      body: Container(
        width: widthScreen,
        height: heightScreen,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance
                    .collection('petugas')
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
                        DocumentSnapshot document = snapshot.data.documents[index];
                        Map<String, dynamic> users = document.data;
                        return Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                title: Text(users['nama lengkap'],
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500)),
                                subtitle: Text(users['jabatan'],
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500)),
                                isThreeLine: false,
                                trailing: PopupMenuButton(
                                  itemBuilder: (BuildContext context) {
                                    return List<PopupMenuEntry<String>>()
                                      ..add(PopupMenuItem<String>(
                                        value: 'hapus',
                                        child: Text('Hapus'),
                                      ));
                                  },
                                  onSelected: (String value) async {
                                    if (value == 'hapus') {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Konfirmasi'),
                                            content: Text(
                                                'Apa kamu ingin menghapus Akun dari ${users['nama lengkap']}?'),
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
                                child: Text(users['nip'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey)),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 16, bottom: 24),
                                child: Text(users['email'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey)),
                              ),
                            ],
                          ),
                        );
                      });
                }))
          ]
        ),
      ),
    );
  }

  addAkun() {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        content: Form(
          key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              TextFormField(
                controller: _namaLengkap,
                decoration: InputDecoration(labelText: 'Nama Lengkap'),
              ),
              TextFormField(
                  controller: _jabatan,
                  decoration: InputDecoration(labelText: 'Jabatan'),
              ),
              TextFormField(
                  controller: _nip,
                  decoration: InputDecoration(labelText: 'NIP'),
              ),
              TextFormField(
                  controller: _email,
                  decoration: InputDecoration(labelText: 'Email'),
              ),
              TextFormField(
                  controller: _password,
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Password',),
              ),
              SizedBox(height: 4),
              Text('Minimal 7 Karakter', style: TextStyle(color: Colors.grey, fontSize: 12)),
            ],),
        ),
          actions: [
             ButtonTheme(
                    minWidth: 330,
                    height: 48,
                    child: RaisedButton(
                      onPressed: () async {
                         if (_formKey.currentState.validate()) {
                            FirebaseAuth.instance.createUserWithEmailAndPassword(
                              email: _email.text, 
                              password: _password.text).then((currentUser) => Firestore.instance.collection('petugas')
                              .document(currentUser.user.uid)
                              .setData({
                                 'nama lengkap': _namaLengkap.text,
                                 'jabatan': _jabatan.text,
                                 'nip': _nip.text,
                                 'email': _email.text,
                                 'password': _password.text,
                              })
                              .then((value) => 
                                Navigator.pop(context)
                               )
                              .catchError((err) => print(err)))
                            .catchError((err) => print(err));
                          }
                      },
                      color: AppColor().colorTertiary,
                      child: Container(
                        margin: EdgeInsets.only(left: cdefaultPadding, right: cdefaultPadding),
                        child: Text('SIMPAN', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ), 
                      ),
                    ),
                  ),
          ],
      );
    });
  }

}