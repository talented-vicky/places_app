import 'package:flutter/material.dart';
import 'package:places_app/views/add_place.dart';

class PlaceList extends StatelessWidget {
  const PlaceList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Places'),
        actions: [
          IconButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(AddPlace.routeName),
              icon: const Icon(Icons.add))
        ],
      ),
      body: const Center(
        child: Text('No Places Yet'),
      ),
    );
  }
}
