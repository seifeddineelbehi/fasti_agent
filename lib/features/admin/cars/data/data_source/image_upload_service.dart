import 'dart:developer';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image/image.dart' as img;
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

@injectable
@singleton
class ImageUploadService {
  final FirebaseStorage _storage;

  ImageUploadService(this._storage);

  Future<Uint8List> _compressImage(PlatformFile file,
      {int maxSizeKB = 500}) async {
    // Get the image bytes from PlatformFile
    Uint8List imageBytes = file.bytes!;
    img.Image? image = img.decodeImage(imageBytes);

    if (image == null) throw Exception('Failed to decode image');

    // Resize image if it's too large (max 800x800 to reduce file size)
    if (image.width > 800 || image.height > 800) {
      image = img.copyResize(
        image,
        width: image.width > image.height ? 800 : null,
        height: image.height > image.width ? 800 : null,
      );
    }

    // Compress with different quality levels until we reach target size
    int quality = 85;
    Uint8List compressedBytes;

    do {
      compressedBytes =
          Uint8List.fromList(img.encodeJpg(image, quality: quality));
      quality -= 10;
    } while (compressedBytes.length > maxSizeKB * 1024 && quality > 10);

    log("Image compressed: Original ${imageBytes.length} bytes -> Compressed ${compressedBytes.length} bytes");
    return compressedBytes;
  }

  Future<String> uploadCarImage({
    required PlatformFile file,
    required String carId,
    required int imageIndex,
  }) async {
    try {
      // Compress the image
      final compressedBytes = await _compressImage(file);

      // Generate unique filename
      final String fileName = '${const Uuid().v4()}_${imageIndex}.jpg';
      final String path = 'cars/$carId/$fileName';

      // Upload to Firebase Storage
      final Reference ref = _storage.ref().child(path);
      final UploadTask uploadTask = ref.putData(
        compressedBytes,
        SettableMetadata(
          contentType: 'image/jpeg',
          customMetadata: {
            'originalName': file.name,
            'carId': carId,
            'imageIndex': imageIndex.toString(),
          },
        ),
      );

      // Wait for upload to complete and get download URL
      final TaskSnapshot snapshot = await uploadTask;
      final String downloadUrl = await snapshot.ref.getDownloadURL();

      log('Image uploaded successfully: $downloadUrl');
      return downloadUrl;
    } catch (e) {
      log('Error uploading image: $e');
      throw Exception('Failed to upload image: $e');
    }
  }

  Future<List<String>> uploadMultipleCarImages({
    required List<PlatformFile> files,
    required String carId,
    Function(int current, int total)? onProgress,
  }) async {
    final List<String> downloadUrls = [];

    for (int i = 0; i < files.length; i++) {
      onProgress?.call(i + 1, files.length);

      final downloadUrl = await uploadCarImage(
        file: files[i],
        carId: carId,
        imageIndex: i,
      );

      downloadUrls.add(downloadUrl);
    }

    return downloadUrls;
  }

  Future<void> deleteCarImages({required String carId}) async {
    try {
      final Reference carFolder = _storage.ref().child('cars/$carId');
      final ListResult listResult = await carFolder.listAll();

      // Delete all images in the car folder
      for (final Reference item in listResult.items) {
        await item.delete();
      }

      log('All images deleted for car: $carId');
    } catch (e) {
      log('Error deleting car images: $e');
      throw Exception('Failed to delete car images: $e');
    }
  }

  Future<void> deleteCarImage({required String imageUrl}) async {
    try {
      final Reference ref = _storage.refFromURL(imageUrl);
      await ref.delete();
      log('Image deleted: $imageUrl');
    } catch (e) {
      log('Error deleting image: $e');
      throw Exception('Failed to delete image: $e');
    }
  }

  // Validate if file is a valid image
  bool isValidImageFile(PlatformFile file) {
    final allowedExtensions = ['jpg', 'jpeg', 'png', 'webp'];
    final fileExtension = file.extension?.toLowerCase();

    return fileExtension != null &&
        allowedExtensions.contains(fileExtension) &&
        file.bytes != null &&
        file.size <= 10 * 1024 * 1024; // 10MB max
  }

  // Get file size in MB
  double getFileSizeInMB(PlatformFile file) {
    return file.size / (1024 * 1024);
  }
}
