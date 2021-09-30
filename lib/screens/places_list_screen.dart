import 'package:flutter/material.dart';
import 'package:my_app2/provider/greate_places.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello world'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/add-places');
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: FutureBuilder(
        future:
            Provider.of<GreatPlaces>(context, listen: false).fetcAndSetPlaces(),
        builder: (ctx, data) => data.connectionState == ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GreatPlaces>(
                child: const Center(
                  child: Text('No Data Was Entry.'),
                ),
                builder: (ctx, data, child) => data.items.isEmpty
                    ? child
                    : ListView.builder(
                        itemBuilder: (ctx, i) => ListTile(
                          leading: CircleAvatar(
                              backgroundImage: FileImage(data.items[i].image)),
                          title: Text(data.items[i].title),
                        ),
                        itemCount: data.items.length,
                      ),
              ),
      ),
    );
  }
}
