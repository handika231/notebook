import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/add_page_controller.dart';

class AddPageView extends GetView<AddPageController> {
  const AddPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 2,
        title: const Text('Add Notes'),
        centerTitle: true,
      ),
      body: Form(
        key: controller.formKey,
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  Obx(
                    () => Center(
                      child: controller.imageFile.value.path.isEmpty
                          ? Image.asset(
                              'assets/add-image.png',
                              width: Get.width,
                              height: Get.height,
                              fit: BoxFit.contain,
                            )
                          : Image.file(
                              controller.imageFile.value,
                              fit: BoxFit.cover,
                              width: Get.width,
                              height: Get.height,
                            ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.defaultDialog(
                        title: 'Select Image',
                        middleText: '',
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () async {
                                await controller.openGallery();
                                Get.back();
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Icon(Icons.image, size: 50),
                                  Text(
                                    "Gallery",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 32.0,
                            ),
                            InkWell(
                              onTap: () async {
                                controller.openCamera();
                                Get.back();
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Icon(Icons.camera_alt, size: 50),
                                  Text(
                                    "Camera",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Container(
                      height: Get.height,
                      width: Get.width,
                      color: Colors.black.withOpacity(0.5),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 6,
              child: Stack(
                children: [
                  Column(
                    children: [
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        maxLines: 1,
                        validator: (value) =>
                            value!.isEmpty ? 'Title is Required' : null,
                        controller: controller.titleController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[200],
                          hintText: "Title",
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14.0,
                          ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Flexible(
                        child: TextFormField(
                          controller: controller.descriptionController,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Description",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 14.0,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
                          maxLines: 20,
                          validator: (value) =>
                              value!.isEmpty ? 'Content is Required' : null,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      bottom: 30,
                    ),
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      child: const Text('Add Note'),
                      onPressed: () {
                        controller.addNote();
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
