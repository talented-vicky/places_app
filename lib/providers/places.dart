import 'dart:io';

import 'package:flutter/material.dart';

import '../models/place.dart';
import '../utility/database.dart';

class Places with ChangeNotifier {
  List<Place> _places = [];

  List<Place> get getPlaces {
    return [..._places];
  }

  void addPlace(String title, File img) async {
    // await PlacesDB.deleteDB();
    // print('successfully deleted places.db');
    // return;
    final place = Place(
      title: title,
      id: DateTime.now().toString(),
      image: img,
      location: null,
      // had to add ? to location final variable to allow for
      // null values to be passed here
    );

    _places.add(place);
    notifyListeners();
    // to ensure he _place is immediately updated after
    // pushing into the list

    await PlacesDB.insertTable('places', place);
    // PlacesDB.insertTable('places', {
    //   'id': place.id,
    //   'title': place.title,
    //   'image': place.image.toString(),
    //   'location': Null,
    // });
  }

  // Future<List<Map<String, dynamic>>> fetchPlaces() async {
  Future<void> fetchPlaces() async {
    final data = await PlacesDB.getData('places');
    print(data);
    print(_places);
    _places = data
        .map((e) => Place(
              id: e['id'],
              title: e['title'],
              location: null,
              image: e['image'],
            ))
        .toList();
    print(_places);
    notifyListeners();
    print('finale'); // why does my code never get here???
  }
}
