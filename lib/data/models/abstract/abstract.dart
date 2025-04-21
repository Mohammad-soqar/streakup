// models/abstract/base_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BaseModel {
  /// Converts the object to a JSON-compatible map for Firestore.
  Map<String, dynamic> toJson();

  /// Generic method to create a model from Firestore
  static T fromSnap<T extends BaseModel>(
      DocumentSnapshot snap, T Function(Map<String, dynamic>) fromJson) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return fromJson(snapshot);
  }
}
