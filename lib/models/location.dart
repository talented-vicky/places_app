class Location {
  final String address;
  final double lat, long;
  const Location({
    required this.lat,
    required this.long,
    this.address = '',
  });
}
