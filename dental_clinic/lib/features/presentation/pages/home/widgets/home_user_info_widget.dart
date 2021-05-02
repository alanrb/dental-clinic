import 'package:dental_clinic/features/presentation/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class HomeUserInfoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return Header('Hi ${user.displayName}!');
    } else {
      return Container();
    }
  }
}
