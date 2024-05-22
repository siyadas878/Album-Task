import 'package:image_picker/image_picker.dart';

Future<XFile?> imagePicking(ImageSource source, [int? imageQuality]) async {
  final image = await ImagePicker().pickImage(source: source);
  if (image != null) {
    return XFile(image.path);
  } else {
    return null;
  }
}

Future<XFile?> profileImagePicking() async {
  final imageData = await ImagePicker()
      .pickImage(source: ImageSource.gallery, imageQuality: 20);
  if (imageData != null) {
    return imageData;
  }
  return null;
}
