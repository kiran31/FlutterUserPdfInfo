import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class UploadController extends GetxController {
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  var isLoading = false.obs;

  Future<void> generateAndUploadPdf() async {
    if (formKey.currentState?.saveAndValidate() ?? false) {
      isLoading.value = true;
      final data = formKey.currentState?.value;

      try {
        final pdf = pw.Document();
        pdf.addPage(
          pw.Page(
            build: (pw.Context context) => pw.Column(
              children: [
                pw.Text('Name: ${data?['name']}'),
                pw.Text('Age: ${data?['age']}'),
                pw.Text('Email: ${data?['email']}'),
                pw.Text('DOB: ${data?['dob']}'),
                pw.Text('Gender: ${data?['gender']}'),
                pw.Text('Employment Status: ${data?['employmentStatus']}'),
                pw.Text('Address: ${data?['address']}'),
              ],
            ),
          ),
        );

        final outputFile = File('${(await getTemporaryDirectory()).path}/${data?['name']}.pdf');
        await outputFile.writeAsBytes(await pdf.save());

        final storageRef = FirebaseStorage.instance.ref().child('pdfs/${data?['name']}.pdf');
        await storageRef.putFile(outputFile);

        await FirebaseFirestore.instance.collection('pdfs').doc('${data?['name']}.pdf').set({
          'name': data?['name'],
          'age': data?['age'],
          'email': data?['email'],
          'dob': data?['dob'],
          'gender': data?['gender'],
          'employmentStatus': data?['employmentStatus'],
          'address': data?['address'],
          'url': await storageRef.getDownloadURL(),
        });

        Get.snackbar('Success', 'PDF uploaded successfully!',
            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green, colorText: Colors.white);
        Get.offAllNamed('/home');
      } catch (e) {
        Get.snackbar('Error', 'Failed to upload PDF. Please try again.',
            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
      } finally {
        isLoading.value = false;
      }
    } else {
      Get.snackbar('Validation Error', 'Please correct the errors in the form.',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.orange, colorText: Colors.white);
    }
  }
}
