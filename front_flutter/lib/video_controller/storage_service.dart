import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;

class Storage {
  final storage = firebase_storage.FirebaseStorage.instance;

  Future<void> uploadFile(
      String filePath,
      String fileName,
      ) async {
    File file = new File(filePath);

    try {
      await storage.ref('uploads/$fileName').putFile(file);
    } on firebase_core.FirebaseException catch(e) {
      print(e);
    }
  }

  Future<firebase_storage.ListResult> listFiles() async {
    firebase_storage.ListResult results = await storage.ref("uploads").listAll();

    results.items.forEach((firebase_storage.Reference ref) {
      print("Found file: $ref");
    });
    return results;
  }

  Future<String> downloadURL(String imageName) async {
    String downloadURL = await storage.ref("uploads/$imageName").getDownloadURL();
    return downloadURL;
  }
}