import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

imagepath(BuildContext context) async {
  var image = await ImagePicker.pickImage(source: ImageSource.camera);
  var apppath = await getApplicationDocumentsDirectory();
  var filename = basename(image.path);
  var localfile = await image.copy('${apppath.path}/$filename');
  return localfile;
}
