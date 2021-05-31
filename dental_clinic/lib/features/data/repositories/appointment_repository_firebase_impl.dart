import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dental_clinic/core/error/failures.dart';
import 'package:dental_clinic/features/data/utils/firestore_utils.dart';
import 'package:dental_clinic/features/domain/model/appointment_model.dart';
import 'package:dental_clinic/features/domain/model/doctor_model.dart';
import 'package:dental_clinic/features/domain/model/issue_case_model.dart';
import 'package:dental_clinic/features/domain/repositories/appointment_repository.dart';
import 'package:flutter/services.dart';

class AppointmentRepositoryFirebaseImpl implements AppointmentRepository {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  @override
  Stream<Either<Failure, List<IssueCaseModel>>> getCases() async* {
    yield* _fireStore.issueCaseCollection.snapshots().map((snapshot) =>
        right(snapshot.docs.map((doc) => doc.issueCase()).toList()));
  }

  @override
  Stream<Either<Failure, List<DoctorModel>>> getDoctor() async* {
    yield* _fireStore.doctorCollection.snapshots().map(
        (snapshot) => right(snapshot.docs.map((doc) => doc.doctor()).toList()));
  }

  @override
  Future<Either<Failure, String>> create(AppointmentModel appointment) async {
    try {
      final result =
          await _fireStore.appointmentCollection.add(appointment.toMap());
      return right(result.id);
    } on PlatformException catch (e) {
      print('create.AppointmentModel: [${e.toString()}]');
      return left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> delete(AppointmentModel appointment) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> update(AppointmentModel appointment) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Stream<Either<Failure, List<AppointmentModel>>> getUserAppointment() {
    // TODO: implement getUserAppointment
    throw UnimplementedError();
  }

  @override
  Stream<Either<Failure, List<AppointmentModel>>> getByUser(
      String userId) async* {
    yield* _fireStore.appointmentCollection
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) => right(snapshot.docs.map((doc) {
              return doc.appointment();
            }).toList()));
  }

  Future<DoctorModel> _getDoctor(String id) async {
    var document = await _fireStore.doctorCollection.doc(id).get();
    return document.doctor();
  }
}

extension DocumentSnapshotParser on DocumentSnapshot {
  IssueCaseModel issueCase() {
    return IssueCaseModel(
        id: this.id,
        title: this.data()!['title'],
        estimation: this.data()!['estimation']);
  }

  DoctorModel doctor() {
    return DoctorModel(
        id: this.id,
        title: this.data()!['title'],
        avatar: this.data()!['avatar'],
        fullName: this.data()!['fullName']);
  }

  AppointmentModel appointment() {
    return AppointmentModel(
        id: this.id,
        branch: this.data()!['branch'],
        time: this.data()!['time'],
        issueId: this.data()!['issueId'],
        issueTitle: this.data()!['issueTitle'],
        userId: this.data()!['userId'],
        doctorId: this.data()!['doctorId'],
        note: this.data()!['note']);
  }
}

extension AppointmentFirebaseDto on AppointmentModel {
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'doctorId': doctorId,
      'issueId': issueId,
      'issueTitle': issueTitle,
      'time': time,
      'branch': branch,
      'note': note ?? '',
      'createdAt': DateTime.now().millisecondsSinceEpoch,
      'updatedAt': DateTime.now().millisecondsSinceEpoch
    };
  }
}
