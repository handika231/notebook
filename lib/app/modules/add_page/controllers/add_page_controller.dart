import 'dart:io';

import 'package:belajar_hive/app/data/db/database_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddPageController extends GetxController implements ImageNotes {
  var imageFile = File('').obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  //create function add note
  Future addNote() async {
    if (formKey.currentState!.validate()) {
      var notes = DBNotes()
        ..title = titleController.text
        ..description = descriptionController.text
        ..image = imageFile.value.path;

      final box = DatabaseManager.getAllNotes();
      int id = await box.add(notes);
      notes.id = id;
      notes.save();
      imageFile.refresh();
      Get.back();
    } else {
      Get.snackbar(
        'Error',
        'Lengkapi dulu formnya',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.lightGreen[200],
        icon: const Icon(Icons.error),
      );
    }
  }

  @override
  Future openCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;
    imageFile.value = File(image.path);
  }

  @override
  Future openGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    imageFile.value = File(image.path);
  }
}

abstract class ImageNotes {
  Future openCamera();
  Future openGallery();
}
