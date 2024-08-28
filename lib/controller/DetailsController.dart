import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:user_info_pdf/screen/DetailsScreen.dart';

class DetailsController extends GetxController {
  late final String fileName;
  var documentData = <String, dynamic>{}.obs;
  var isLoading = true.obs;
  var hasError = false.obs;

  DetailsController(this.fileName);



  @override
  void onInit() {
    super.onInit();
    fetchDocumentDetails();
  }

  Future<void> fetchDocumentDetails() async {
    try {
      isLoading(true);
      hasError(false);
      final doc = await FirebaseFirestore.instance.collection('pdfs').doc(fileName).get();
      if (doc.exists) {
        documentData.value = doc.data() as Map<String, dynamic>;
      } else {
        hasError(true);
      }
    } catch (e) {
      hasError(true);
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteOldFile() async {
    try {
      final storageRef = FirebaseStorage.instance.ref().child('pdfs/$fileName');
      await storageRef.delete();
      await FirebaseFirestore.instance.collection('pdfs').doc(fileName).delete();
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete the old file');
    }
  }

  Future<void> deleteFile() async {
    try {
      await deleteOldFile();
      Get.offNamed('/home');
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete the file');
    }
  }

  Future<void> editFile(BuildContext context) async {
    try {
      // await deleteOldFile();
      final doc = await FirebaseFirestore.instance.collection('pdfs').doc(fileName).get();
      final data = doc.data() as Map<String, dynamic>;
      Get.offNamed('/upload', arguments: {'data': data, 'shouldDelete': true, 'detailsController': this});
    } catch (e) {
      Get.snackbar('Error', 'Failed to edit the file');
    }
  }
}
