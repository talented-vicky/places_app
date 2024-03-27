import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/places.dart';
import '../views/add_place.dart';

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
        body: FutureBuilder(
          future: Provider.of<Places>(context).fetchPlaces(),
          builder: (BuildContext context, AsyncSnapshot snp) => snp
                      .connectionState ==
                  ConnectionState.waiting
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<Places>(
                  // child: Consumer<Places>(
                  child: const Center(
                    child: Text('No Places Yet'),
                  ),
                  builder: (ctxt, places,
                          ch /* this will be the static child 
                      (I just defined before builder) that won't 
                       change even if data changes*/
                          ) =>
                      places.getPlaces.isEmpty
                          ? ch!
                          : ListView.builder(
                              itemCount: places.getPlaces.length,
                              itemBuilder: (BuildContext context, int ind) =>
                                  ListTile(
                                leading: CircleAvatar(
                                  backgroundImage:
                                      FileImage(places.getPlaces[ind].image),
                                ),
                                title: Text(places.getPlaces[ind].title),
                                onTap: () {
                                  // details
                                },
                              ),
                            )),
        ));
  }
}
