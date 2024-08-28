import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:user_info_pdf/controller/DetailsController.dart';

import '../controller/upload_controller.dart';

class UploadScreen extends StatelessWidget {
  final UploadController controller = Get.put(UploadController());

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args = Get.arguments as Map<String, dynamic>?;
    final DetailsController? detailsController = args?['detailsController'] as DetailsController?;
    final Map<String, dynamic>? documentData = args?['data'];
    final bool shouldDelete = args?['shouldDelete'] ?? false;
    controller.formKey.currentState?.patchValue(documentData ?? {});

    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Personal Information'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: controller.formKey,
          child: ListView(
            children: [
              FormBuilderTextField(
                name: 'name',
                initialValue: documentData?['name'],
                // Set initial value
                decoration: const InputDecoration(
                  labelText: 'Name',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Name is required';
                  } else if (value.length < 3) {
                    return 'Minimum 3 characters required';
                  }
                  return null;
                },
                keyboardType: TextInputType.name,
              ),
              const SizedBox(height: 10),
              FormBuilderTextField(
                name: 'age',
                initialValue: documentData?['age'],
                // Set initial value
                decoration: const InputDecoration(
                  labelText: 'Age',
                  prefixIcon: Icon(Icons.cake),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Age is required';
                  } else if (int.tryParse(value) == null) {
                    return 'Age must be a number';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              FormBuilderTextField(
                name: 'email',
                initialValue: documentData?['email'],
                // Set initial value
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  } else if (!RegExp(
                          r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                      .hasMatch(value)) {
                    return 'Enter a valid email address';
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 10),
              FormBuilderDateTimePicker(
                name: 'dob',
                initialValue: documentData?['dob']?.toDate(),
                // Convert timestamp to DateTime
                decoration: const InputDecoration(
                  labelText: 'Date of Birth',
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                initialDatePickerMode: DatePickerMode.year,
                inputType: InputType.date,
                validator: (value) {
                  if (value == null) {
                    return 'Date of Birth is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              FormBuilderDropdown<String>(
                name: 'gender',
                initialValue: documentData?['gender'],
                // Set initial value
                decoration: const InputDecoration(
                  labelText: 'Gender',
                  prefixIcon: Icon(Icons.wc),
                ),
                items: ['Male', 'Female']
                    .map((gender) =>
                        DropdownMenuItem(value: gender, child: Text(gender)))
                    .toList(),
                validator: (value) {
                  if (value == null) {
                    return 'Gender is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              FormBuilderTextField(
                name: 'employmentStatus',
                initialValue: documentData?['employmentStatus'],
                // Set initial value
                decoration: const InputDecoration(
                  labelText: 'Employment Status',
                  prefixIcon: Icon(Icons.work),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Employment Status is required';
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 10),
              FormBuilderTextField(
                name: 'address',
                initialValue: documentData?['address'],
                // Set initial value
                decoration: const InputDecoration(
                  labelText: 'Address',
                  prefixIcon: Icon(Icons.home),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Address is required';
                  }
                  return null;
                },
                keyboardType: TextInputType.streetAddress,
              ),
              const SizedBox(height: 20),
              Obx(() {
                return ElevatedButton.icon(
                  onPressed:  controller.isLoading.value
                      ? null : () async {
                    if (controller.formKey.currentState?.saveAndValidate() ??
                        false) {
                      if (shouldDelete) {
                        await detailsController?.deleteOldFile();
                      }

                      await controller.generateAndUploadPdf();
                    } else {
                      Get.snackbar('Validation Error',
                          'Please correct the errors in the form.',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.orange,
                          colorText: Colors.white);
                    }
                  },
                  icon: controller.isLoading.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Icon(Icons.cloud_upload, color: Colors.white,),
                  label: const Text('Upload PDF',style: TextStyle(color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(color: Colors.white),
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 20),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
/*
() async {
if (controller.formKey.currentState?.saveAndValidate() ?? false) {
if (shouldDelete) {
// If shouldDelete is true, delete the old file
await detailsController.deleteOldFile();
}

await controller.generateAndUploadPdf();
} else {
Get.snackbar('Validation Error', 'Please correct the errors in the form.',
snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.orange, colorText: Colors.white);
}
}*/
