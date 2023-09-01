import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'dart:typed_data';

Future<Uint8List> resizeAndCompressImage(Uint8List imageBytes) async {
  final result = await FlutterImageCompress.compressWithList(
    imageBytes,
    minHeight: 1920, // Set your desired height
    minWidth: 1080, // Set your desired width
    quality: 70, // Adjust the image quality (0 to 100)
  );

  return Uint8List.fromList(result);
}
