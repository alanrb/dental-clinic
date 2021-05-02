import 'package:cloud_firestore/cloud_firestore.dart';

extension AppFireStore on FirebaseFirestore {
  CollectionReference get branch => collection('branch');

  CollectionReference get issueCaseCollection => collection('issueCase');

  CollectionReference get doctorCollection => collection('doctor');

  CollectionReference get appointmentCollection => collection('appointment');

  Future<DocumentReference> branchDocument(String id) async {
    return FirebaseFirestore.instance.branch.doc(id);
  }
}

extension AppDocumentReference on DocumentReference {

}
