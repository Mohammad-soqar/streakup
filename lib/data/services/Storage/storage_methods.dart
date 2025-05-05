import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadChallengeImageToStorage({
    required String challengeId,
    required Uint8List file,
    required String fileName, 
  }) async {
    Reference ref = _storage.ref().child('challenges/$challengeId/$fileName');
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snap = await uploadTask;
    return await snap.ref.getDownloadURL();
  }
}
