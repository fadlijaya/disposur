import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> userSetup (String displayName, String nip, String jabatan, String email) async {
  CollectionReference users = Firestore.instance.collection('akun');
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser().toString();
  users.add({
    'uid': uid,
    'displayName': displayName,
    'nip': nip,
    'jabatan': jabatan,
    'email': email,
  });
  return;
}