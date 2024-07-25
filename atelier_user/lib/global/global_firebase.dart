import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class GlobalFirebase{
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore cloud = FirebaseFirestore.instance;
  static final storage = FirebaseStorage.instance;
}