import 'package:flutter/material.dart';

import '../models/place.dart';

class Places with ChangeNotifier {
  List<Place> _places = [];

  get getPlaces {
    return [..._places];
  }
}
