import 'dart:io';

class Location {
  final String address;
  final double lat, long;
  Location({required this.lat, required this.long, this.address = ''});
}

class Place {
  final String title, id;
  final Location location;
  final File image;
  Place(
      {required this.title,
      required this.id,
      required this.location,
      required this.image});
}
