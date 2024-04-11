import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/location.dart';

class GoogleMaps extends StatefulWidget {
  final Location initLoc;
  final bool isPicking;
  const GoogleMaps({
    super.key,
    this.initLoc = const Location(lat: 37.422, long: -122.984),
    this.isPicking = false,
    // user is not picking hence show default location I set
  });

  @override
  State<GoogleMaps> createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  LatLng? _pickedLocation;

  void _changeLocation(LatLng location) {
    setState(() {
      _pickedLocation = location;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('google maps'),
        actions: [
          widget.isPicking
              ? IconButton(
                  onPressed: _pickedLocation == null
                      ? null
                      : () => Navigator.of(context).pop(_pickedLocation),
                  // I return "_pickedLocation" after I pop because I am
                  // expecting such in _showMap funct in "add_place.dart" file
                  icon: const Icon(Icons.save))
              : const Icon(Icons.done)
        ],
      ),
      body: GoogleMap(
        // remember this assumes/takes the height and width of parent widget
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.initLoc.lat, widget.initLoc.long),
          zoom: 20,
        ),
        onTap: widget.isPicking ? _changeLocation : null,
        markers: _pickedLocation == null
            ? {}
            : {
                Marker(
                  markerId: const MarkerId('dd'),
                  position: _pickedLocation!,
                )
              },
      ),
    );
  }
}
