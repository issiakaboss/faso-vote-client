import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class ImageHelper {
  static Future<Uint8List?> compressImage(
    PlatformFile file, {
    bool isGallery = false,
  }) async {
    try {
      if (kIsWeb) {
        return await _compressImageWeb(file, isGallery: isGallery);
      }
      return await _compressImageMobile(file, isGallery: isGallery);
    } catch (e) {
      debugPrint('Compression error: $e');
      return file.bytes;
    }
  }

  static Future<Uint8List?> _compressImageMobile(
    PlatformFile file, {
    required bool isGallery,
  }) async {
    final quality = isGallery ? 65 : 75;
    final minWidth = isGallery ? 800 : 1024;
    final minHeight = isGallery ? 800 : 1024;

    if (file.bytes != null) {
      return await FlutterImageCompress.compressWithList(
        file.bytes!,
        quality: quality,
        minWidth: minWidth,
        minHeight: minHeight,
        format: CompressFormat.jpeg,
      );
    }

    return await FlutterImageCompress.compressWithFile(
      file.path!,
      quality: quality,
      minWidth: minWidth,
      minHeight: minHeight,
      format: CompressFormat.jpeg,
    );
  }

  static Future<Uint8List?> _compressImageWeb(
    PlatformFile file, {
    required bool isGallery,
  }) async {
    try {
      if (file.bytes != null) {
        return await FlutterImageCompress.compressWithList(
          file.bytes!,
          quality: isGallery ? 65 : 75,
          minWidth: isGallery ? 800 : 1024,
          minHeight: isGallery ? 800 : 1024,
          format: CompressFormat.jpeg,
        );
      }
      return file.bytes;
    } catch (e) {
      debugPrint('Web compression error: $e');
      return file.bytes;
    }
  }
}
