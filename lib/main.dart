import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../providers/places.dart';
import '../views/places_list.dart';
import '../views/add_place.dart';

void main() {
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider.value(
      value: Places(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Cool-Places",
        home: const PlaceList(),
        routes: {
          AddPlace.routeName: (ctxt) => const AddPlace(),
        },
      ));
}
