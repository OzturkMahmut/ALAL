import 'package:deneme1/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

CustomTheme currentTheme = CustomTheme();


 

pickImage(ImageSource source) async {
  final ImagePicker _imagepicker = ImagePicker();

  XFile? _file = await _imagepicker.pickImage(source: source);

  if (_file != null) {
    return await _file.readAsBytes();
  } else {
  }
}

showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}
