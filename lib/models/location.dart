class Location {
  final String address;
  final double lat, long;
  Location({
    required this.lat,
    required this.long,
    this.address = '',
  });
}
