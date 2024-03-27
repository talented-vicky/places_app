import 'dart:io';

import '../models/location.dart';

class Place {
  final String title, id;
  final Location? location;
  final File image;

  Place({
    required this.title,
    required this.id,
    required this.location,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'image': image.toString(),
      'location': null,
    };
  }

  @override
  String toString() {
    return 'Place{title: $title, id: $id, location: $location, image: $image}';
  }
}
