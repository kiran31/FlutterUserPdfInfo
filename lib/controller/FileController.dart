import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FileController extends GetxController {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  var fileNames = <String>[].obs;
  var isLoading = true.obs;
  var hasError = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchFileNames();
  }

  @override
  void onReady() {
    super.onReady();
    fetchFileNames();
  }


  Future<void> fetchFileNames() async {
    try {
      isLoading(true);
      hasError(false);
      final ListResult result = await _storage.ref().child('pdfs').listAll();
      fileNames.value = result.items.map((ref) => ref.name).toList();
    } catch (e) {
      hasError(true);
    } finally {
      isLoading(false);
    }
  }
}
