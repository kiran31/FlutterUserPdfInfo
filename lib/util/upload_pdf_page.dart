import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../controller/pdf_controller.dart';

class UploadPDFPage extends StatelessWidget {
  final _pdfController = Get.find<PDFController>();
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Upload PDF')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'PDF Name'),
                    validator: (value) => value == null || value.isEmpty ? 'Please enter a name' : null,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _pickAndUploadPDF,
                    child: Text('Upload PDF'),
                  ),
                ],
              ),
            ),
            Obx(() {
              if (_pdfController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }
              return Container();
            }),
          ],
        ),
      ),
    );
  }

  Future<void> _pickAndUploadPDF() async {
    if (!_formKey.currentState!.validate()) return;
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    final file = File(pickedFile.path);
    final name = _nameController.text;

    await _pdfController.uploadPDF(file, name);
    Get.back();  // Go back to the list page
  }
}
