import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:user_info_pdf/screen/DetailsScreen.dart';
import 'package:user_info_pdf/screen/UploadScreen.dart';

import 'screen/HomeScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'PDF Manager',
      initialRoute: '/home',
      routes: {
        '/home': (context) => HomeScreen(),
        '/upload': (context) => UploadScreen(),
        '/details': (context) => DetailsScreen(),
      },
    );
  }
}
