import 'dart:io';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:places_app/utility/location.dart';
import 'package:provider/provider.dart';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import '../providers/places.dart';

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
    // _pickImg(finalImg);
    _imagefile = XFile(finalImg.path);
  }

  Location location = Location();

  // Future<bool> _permitLocation() async {
  //   final result = await location.requestPermission();
  //   return result == PermissionStatus.granted;
  // }

  // Future<LocationData> _getLocation() async {
  Future<void> _getLocation() async {
    // _permitLocation();

    // final service = await location.serviceEnabled();
    // if (!service) {
    //   final bool res = await location.requestService();
    //   if (res == true) {
    //     print('service now enabled');
    //   } else {
    //     throw Exception('service not enabled');
    //   }
    // }
    final userLoc = await location.getLocation();
    print(userLoc);
    PlacesLoc.googleLocation(userLoc.latitude!, userLoc.longitude!);
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
                          onPressed: () {},
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
