import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/DetailsController.dart';

class DetailsScreen extends StatelessWidget {

  Future<void> _showConfirmationDialog(BuildContext context, DetailsController controller) async {
    final bool? shouldDelete = await showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Confirm Deletion'),
        content: const Text('Are you sure you want to delete this file?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (shouldDelete == true) {
      controller.deleteFile();
    }
  }

  @override
  Widget build(BuildContext context) {
    final String fileName = Get.arguments as String;
    final DetailsController controller = Get.put(DetailsController(fileName));

    return Scaffold(
      appBar: AppBar(
        title: const Text('File Details'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.hasError.value || controller.documentData.isEmpty) {
          return const Center(child: Text('File not found.'));
        } else {
          final data = controller.documentData;

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name: ${data['name']}',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
                    const SizedBox(height: 10),
                    Text('Age: ${data['age']}',
                        style: TextStyle(fontSize: 16, color: Colors.black54)),
                    Text('Email: ${data['email']}',
                        style: TextStyle(fontSize: 16, color: Colors.black54)),
                    Text('DOB: ${data['dob']}',
                        style: TextStyle(fontSize: 16, color: Colors.black54)),
                    Text('Gender: ${data['gender']}',
                        style: TextStyle(fontSize: 16, color: Colors.black54)),
                    Text('Employment Status: ${data['employmentStatus']}',
                        style: TextStyle(fontSize: 16, color: Colors.black54)),
                    Text('Address: ${data['address']}',
                        style: TextStyle(fontSize: 16, color: Colors.black54)),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () => controller.editFile(context),
                          icon: const Icon(Icons.edit),
                          label: const Text('Edit'),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white, backgroundColor: Colors.blueAccent,
                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () => _showConfirmationDialog(context, controller),
                          icon: const Icon(Icons.delete),
                          label: const Text('Delete'),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white, backgroundColor: Colors.redAccent,
                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      }),
    );
  }
}
