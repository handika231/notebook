import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/data/db/database_manager.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(DBNotesAdapter());
  await Hive.openBox<DBNotes>('notes');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.black,
        ),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.lightGreen,
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: "Note Books",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
