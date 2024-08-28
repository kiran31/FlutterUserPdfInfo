// screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/DetailsController.dart';
import '../controller/FileController.dart';
import 'DetailsScreen.dart';

class HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver{
  final FileController fileController = Get.put(FileController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this); // Add observer
    _fetchFilesAfterBuild();
  }
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this); // Remove observer
    super.dispose();
  }
  void _fetchFilesAfterBuild() {
    Future.microtask(() {
      fileController.fetchFileNames();
    });
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Call fetchFileNames() when returning to the screen
    if (state == AppLifecycleState.resumed) {
      fileController.fetchFileNames();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Fetch data whenever the screen is focused again
    fileController.fetchFileNames();
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Exit App'),
        content: const Text('Do you really want to exit the app?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('OK'),
          ),
        ],
      ),
    )) ?? false;
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Uploaded Files'),
        ),
        body: Obx(() {
          if (fileController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (fileController.hasError.value) {
            return const Center(child: Text('Error fetching files.'));
          } else if (fileController.fileNames.isEmpty) {
            return const Center(child: Text('No files uploaded.'));
          } else {
            return ListView.builder(
              itemCount: fileController.fileNames.length,
              itemBuilder: (context, index) {
                final fileName = fileController.fileNames[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.picture_as_pdf, color: Colors.red),
                    title: Text(fileName, style: TextStyle(fontWeight: FontWeight.bold)),
                    trailing: Icon(Icons.arrow_forward, color: Theme.of(context).primaryColor),
                    onTap: () {
                     /* // Navigator.pushNamed(context, '/details',);
                      // Get.put(DetailsController(fileName));*/
                      Get.to(() => DetailsScreen(), arguments: fileName);
                    },
                  ),
                );
              },
            );
          }
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/upload');
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
