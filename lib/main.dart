import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/places.dart';
import '../views/places_list.dart';
import '../views/add_place.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: Places(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Welcome INit",
          home: PlaceList(),
          routes: {
            AddPlace.routeName: (ctxt) => AddPlace(),
          },
        ));
  }
}
