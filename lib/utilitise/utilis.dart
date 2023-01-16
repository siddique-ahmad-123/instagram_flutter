
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource Source) async {
  final ImagePicker _imagePicker = ImagePicker();
  _imagePicker.pickImage(source: Source);
  XFile? _file = await _imagePicker.pickImage(source: Source);

  if (_file != null) {
    return await _file.readAsBytes();
  }
  print('No image selected');

  showSnackBar(String content, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
        ),
    );
  }
}
