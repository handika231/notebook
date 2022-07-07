import 'dart:io';

import 'package:belajar_hive/app/data/db/database_manager.dart';
import 'package:belajar_hive/app/modules/add_page/controllers/add_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditPageController extends GetxController implements ImageNotes {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var imageFile = File('').obs;

  Future editNote(DBNotes notes) async {
    if (formKey.currentState!.validate()) {
      notes.title = titleController.text;
      notes.description = descriptionController.text;
      notes.image = imageFile.value.path;
      notes.save();
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
