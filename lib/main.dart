import 'package:flutter/material.dart';
import './provider/greate_places.dart';
import './screens/add_place_screen.dart';
import './screens/places_list_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GreatPlaces(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: const PlacesListScreen(),
        routes: {
          '/add-places': (ctx) => const AddPlaceScreen(),
        },
      ),
    );
  }
}
