class AppointmentModel {
  const AppointmentModel(
      {this.id,
      required this.userId,
      required this.issueId,
      required this.issueTitle,
      required this.time,
      required this.branch,
      required this.doctorId,
      this.note});

  final String? id;
  final String userId;
  final String issueId;
  final String issueTitle;
  final int time;
  final String branch;
  final String doctorId;
  final String? note;

  String toString() => '$issueTitle, (id=$userId)';
}
