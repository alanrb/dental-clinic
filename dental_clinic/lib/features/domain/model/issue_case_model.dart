import 'package:equatable/equatable.dart';

class IssueCaseModel extends Equatable {
  final String id;
  final String title;
  final String estimation;

  IssueCaseModel(
      {required this.id, required this.title, required this.estimation});

  String toString() => '$title (id=$id)';

  @override
  List<Object?> get props => [id, title, estimation];
}
