import 'package:cloud_firestore/cloud_firestore.dart';

class ContactService {
  final String firestoreCollection = 'contacts';

  Future<void> addContact(contact) async {
    Firestore.instance
        .collection(firestoreCollection)
        .add(contact)
        .catchError((e) {
      print(e);
    });
  }

  Future<void> deleteContact(docId) async {
    Firestore.instance
        .collection(firestoreCollection)
        .document(docId)
        .delete()
        .catchError((e) {
      print(e);
    });
  }

  Future<void> updateData(docId, newValues) async {
    Firestore.instance
        .collection(firestoreCollection)
        .document(docId)
        .updateData(newValues)
        .catchError((e) {
      print(e);
    });
  }
}