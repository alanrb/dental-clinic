
class DoctorModel {
  final String id;
  final String avatar;
  final String fullName;
  final String title;

  DoctorModel({required this.id, required this.avatar, required this.fullName, required this.title});

  String toString() => '$fullName $title (id=$id)';
}