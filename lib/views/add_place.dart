import 'dart:io';

import 'package:flutter/material.dart';

class AddPlace extends StatefulWidget {
  static const routeName = '/add-place';

  AddPlace({super.key});

  @override
  State<AddPlace> createState() => _AddPlaceState();
}

class _AddPlaceState extends State<AddPlace> {
  final _txtCtrl = TextEditingController();
  File? imagefile;

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
                          onPressed: () {},
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
