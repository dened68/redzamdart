import 'package:flutter/material.dart';
import 'package:redzamdart/pages/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  initFirebase();
  initFirebase();
  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: Colors.orange[700],
    ),
    home: Home(),
  ));
}

void initFirebase() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}
