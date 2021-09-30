import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;
  const ImageInput({Key key, this.onSelectImage}) : super(key: key);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;
  final _picker = ImagePicker();

  Future<void> _takPicture() async {
    final XFile imageFile =
        await _picker.pickImage(source: ImageSource.camera, maxWidth: 600);
    if (imageFile == null) {
      return;
    }

    setState(() {
      _storedImage = File(imageFile.path);
    });
    final appDir = await syspath.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedFile = await _storedImage.copy('${appDir.path}/$fileName');
    widget.onSelectImage(savedFile);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            width: 150,
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
            ),
            alignment: Alignment.center,
            child: _storedImage != null
                ? Image.file(File(_storedImage.path),
                    fit: BoxFit.cover, width: double.infinity)
                : const Text('No Image Taken', textAlign: TextAlign.center)),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: TextButton.icon(
              onPressed: _takPicture,
              icon: const Icon(Icons.camera),
              label: const Text('Take Picture')),
        )
      ],
    );
  }
}