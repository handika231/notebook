import 'dart:io';

import 'package:belajar_hive/app/data/db/database_manager.dart';
import 'package:belajar_hive/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.ADD_PAGE);
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('All Notes Books'),
        centerTitle: true,
      ),
      body: ValueListenableBuilder<Box<DBNotes>>(
        valueListenable: DatabaseManager.getAllNotes().listenable(),
        builder: (BuildContext context, value, _) {
          List<DBNotes> notes = value.values.toList();
          return value.isNotEmpty
              ? ListView.builder(
                  itemCount: notes.length,
                  itemBuilder: (BuildContext context, int index) {
                    DBNotes note = notes[index];
                    return note.image == null
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Slidable(
                            key: Key(note.id.toString()),
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 16,
                                  ),
                                  onPressed: (context) {
                                    Get.toNamed(Routes.EDIT_PAGE,
                                        arguments: note);
                                  },
                                  backgroundColor: Colors.lightGreen,
                                  foregroundColor: Colors.white,
                                  icon: Icons.save,
                                  label: 'Edit',
                                ),
                                SlidableAction(
                                  borderRadius: BorderRadius.circular(8),
                                  onPressed: (context) {
                                    Get.defaultDialog(
                                      textConfirm: 'Delete',
                                      onConfirm: () {
                                        note.delete();
                                        Get.back();
                                      },
                                      confirmTextColor: Colors.black,
                                      cancelTextColor: const Color(0xFFD0D0D0),
                                      textCancel: 'Batal',
                                      title: 'Delete Note',
                                      middleText:
                                          'Apakah kamu yakin menghapus note ini?',
                                      onCancel: () => Get.back(),
                                    );
                                  },
                                  padding: const EdgeInsets.symmetric(),
                                  backgroundColor: const Color(0xFFFE4A49),
                                  foregroundColor: Colors.white,
                                  icon: Icons.archive,
                                  label: 'Delete',
                                ),
                              ],
                            ),
                            child: Card(
                              color: Colors.grey[350],
                              margin: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 16,
                              ),
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Flexible(
                                    flex: 4,
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(8),
                                        topLeft: Radius.circular(8),
                                      ),
                                      child: Image.file(
                                        File(
                                          note.image!,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 24,
                                  ),
                                  Flexible(
                                    flex: 6,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          note.title ?? 'No Data',
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const Divider(
                                          color: Colors.grey,
                                        ),
                                        Text(
                                          note.description ?? 'No Data',
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                  },
                )
              : Center(
                  child: Lottie.asset('assets/empty.json'),
                );
        },
      ),
    );
  }
}
