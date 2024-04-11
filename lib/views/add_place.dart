import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import '../views/google_maps.dart';
import '../utility/ggl_location.dart';
import '../providers/places.dart';
import '../models/location.dart';

class AddPlace extends StatefulWidget {
  static const routeName = '/add-place';

  const AddPlace({super.key});

  @override
  State<AddPlace> createState() => _AddPlaceState();
}

class _AddPlaceState extends State<AddPlace> {
  final _txtCtrl = TextEditingController();
  XFile? _imagefile;
  String? _locationImg;

  void _save(BuildContext context) {
    if (_txtCtrl.text.isEmpty || _imagefile == null) {
      return;
    }
    Provider.of<Places>(context, listen: false)
        .addPlace(_txtCtrl.text, File(_imagefile!.path));
    Navigator.of(context).pop();
  }

  Future<void> _takePics() async {
    final ImagePicker imgPicker = ImagePicker();
    final XFile? img =
        await imgPicker.pickImage(source: ImageSource.gallery, maxWidth: 500);
    // set permissions at ios>>runner>>base.lproj>>info.plist
    if (img == null) {
      return;
    }
    setState(() {
      _imagefile = XFile(img.path);
    });

    final appDir = await getApplicationDocumentsDirectory();
    final name = basename(_imagefile!.path);

    final finalImg = await File(_imagefile!.path).copy('${appDir.path}/$name');
    // image now copied to working directory
    _imagefile = XFile(finalImg.path);
  }

  // Future<bool> _serviceCheck() async {
  //   bool isServiceEnabled;

  //   isServiceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!isServiceEnabled) {
  //     return Future.error('Location services disabled');
  //   }
  //   return isServiceEnabled;
  // }

  // Future<LocationPermission> _permissionCheck() async {
  //   late LocationPermission permission;
  //   final service = await _serviceCheck();

  //   if (service) {
  //     permission = await Geolocator.checkPermission();
  //     if (permission == LocationPermission.denied) {
  //       // if permission is denied, ask for it
  //       permission == await Geolocator.requestPermission();
  //       if (permission == LocationPermission.denied) {
  //         throw Future.error('Location permissions denied');
  //       }
  //     }
  //   }
  //   return permission;
  // }

  Future<void> _getLocation() async {
    // _permissionCheck();
    final userPos = await Geolocator.getCurrentPosition();
    print(userPos);
    final locImag =
        PlacesLoc.googleLocation(userPos.latitude, userPos.longitude);
    setState(() {
      _locationImg = locImag;
    });
  }

  Future<void> _showMap(context) async {
    // final LatLng pickedLoc = await Navigator.of(context).push(MaterialPageRoute(
    final pickedLoc =
        await Navigator.of(context).push<LatLng>(MaterialPageRoute(
      fullscreenDialog: true,
      builder: (ctxt) => const GoogleMaps(isPicking: true),
    ));
    // this pickeLoc is what I will receive when I pop the GoogleMaps

    if (pickedLoc == null) {
      return;
    }
    print(pickedLoc);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('Add Place')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: SingleChildScrollView(
                  padding: const EdgeInsets.all(5),
                  child: Column(children: [
                    TextField(
                        decoration: const InputDecoration(labelText: 'Title'),
                        controller: _txtCtrl),
                    const SizedBox(height: 15),
                    // image
                    Row(children: [
                      Container(
                        width: 120,
                        height: 120,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1)),
                        alignment: Alignment.center,
                        child: _imagefile != null
                            ? Image.file(File(_imagefile!.path),
                                fit: BoxFit.cover, width: double.infinity)
                            : const Text('No image'),
                      ),
                      const SizedBox(width: 50),
                      TextButton.icon(
                          onPressed: () => _takePics(),
                          icon: const Icon(Icons.camera),
                          label: const Text('Take Picture'))
                    ]),
                    const SizedBox(height: 10),
                    // location
                    Container(
                      height: 150,
                      alignment: Alignment.center,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey)),
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: _locationImg == null
                          ? const Text(
                              'No location chosen',
                              textAlign: TextAlign.center,
                            )
                          : Image.network(
                              _locationImg!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton.icon(
                          onPressed: () => _getLocation(),
                          icon: const Icon(Icons.location_on),
                          label: const Text('Add Location'),
                        ),
                        TextButton.icon(
                          onPressed: () => _showMap(context),
                          icon: const Icon(Icons.location_searching),
                          label: const Text('Select From Map'),
                        ),
                      ],
                    )
                  ]))),
          ElevatedButton.icon(
              onPressed: () => _save(context),
              icon: const Icon(Icons.add),
              label: const Text('Add Place'))
        ],
      ));
}
