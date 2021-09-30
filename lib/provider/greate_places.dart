import 'package:flutter/widgets.dart';
import 'package:my_app2/helper/db_helper.dart';
import '../models/place.dart';
import 'dart:io';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String title, File pickedImage) {
    final newPlaces = Place(
        id: DateTime.now().toString(),
        title: title,
        location: null,
        image: pickedImage);
    _items.add(newPlaces);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlaces.id,
      'title': newPlaces.title,
      'image': newPlaces.image.path
    });
  }

  Future<void> fetcAndSetPlaces() async {
    final getData = await DBHelper.getData('user_places');
    _items = getData
        .map((item) => Place(
            id: item['id'],
            title: item['title'],
            location: null,
            image: File(item['image'])))
        .toList();
  }
}
