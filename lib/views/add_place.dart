import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class AddPlace extends StatefulWidget {
  static const routeName = '/add-place';

  AddPlace({super.key});

  @override
  State<AddPlace> createState() => _AddPlaceState();
}

class _AddPlaceState extends State<AddPlace> {
  final _txtCtrl = TextEditingController();
  File? imagefile;

  Future<void> _pickImage() async {
    final imgPicker = ImagePicker();
    final img =
        await imgPicker.pickImage(source: ImageSource.gallery, maxWidth: 500);
    // set permissions at ios>>runner>>base.lproj>>info.plist
    setState(() async {
      imagefile = File(img!.path);

      final appDir = await getApplicationDocumentsDirectory();
      final name = basename(imagefile!.path);
      await imagefile!.copy('${appDir.path}/$name');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Place'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(5),
              child: Column(
                children: [
                  TextField(
                    decoration: const InputDecoration(labelText: 'Title'),
                    controller: _txtCtrl,
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1),
                        ),
                        alignment: Alignment.center,
                        child: imagefile != null
                            ? Image.file(imagefile!,
                                fit: BoxFit.cover, width: double.infinity)
                            : const Text('No image'),
                      ),
                      const SizedBox(width: 50),
                      TextButton.icon(
                          onPressed: () => _pickImage(),
                          icon: const Icon(Icons.camera),
                          label: const Text('Take Picture'))
                    ],
                  )
                ],
              ),
            ),
          ),
          ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text('Add Place'))
        ],
      ),
    );
  }
}

// class MyCamDelegate extends ImagePickerCameraDelegate {
//   Future<void> _pickImage(stuff) async {
//     final imgPicker = ImagePicker();
//     final img =
//         await imgPicker.pickImage(source: ImageSource.camera, maxWidth: 500);
//     // set permissions at ios>>runner>>base.lproj>>info.plist
//   }

//   @override
//   Future<void> takePics(
//       {ImagePickerCameraDelegateOptions options =
//           const ImagePickerCameraDelegateOptions()}) async {
//     return _pickImage(options.preferredCameraDevice);
//   }
// }

// void setupCamDelegate() {
//   final ImagePickerPlatform inst = ImagePickerPlatform()
// }
