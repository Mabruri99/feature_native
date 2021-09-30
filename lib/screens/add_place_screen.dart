import 'package:flutter/material.dart';
import 'package:my_app2/models/place.dart';
import 'package:my_app2/provider/greate_places.dart';
import 'package:my_app2/widgets/location_input.dart';
import 'package:provider/provider.dart';
import '../widgets/image_input.dart';
import 'dart:io';

class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({Key key}) : super(key: key);

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File _pickedImage;
  PlaceLocation _pickedLocation;
  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _getLocation(double lat, double long) {
    _pickedLocation = PlaceLocation(latitude: lat, longitude: long);
  }

  void _savePlace() {
    if (_titleController.text.isEmpty ||
        _pickedImage == null ||
        _pickedLocation == null) {
      return;
    }
    Provider.of<GreatPlaces>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add A New Place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        labelText: 'Title',
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  ImageInput(
                    onSelectImage: _selectImage,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  LocatoinInput(
                    ambillok: _getLocation,
                  )
                ],
              ),
            ),
          )),
          ElevatedButton.icon(
            onPressed: _savePlace,
            icon: const Icon(Icons.add),
            label: const Text('Add Places'),
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              elevation: 0,
              fixedSize: Size(
                  double.infinity, MediaQuery.of(context).size.height * 0.06),
            ),
          )
        ],
      ),
    );
  }
}
