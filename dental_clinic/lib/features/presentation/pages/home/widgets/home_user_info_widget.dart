import 'package:dental_clinic/features/presentation/pages/login/bloc/authentication_bloc.dart';
import 'package:dental_clinic/features/presentation/styles.dart';
import 'package:dental_clinic/features/presentation/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeUserInfoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      var user = FirebaseAuth.instance.currentUser;
      if (user != null && state is Authenticated) {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Header('Hi ${user.displayName}!'),
          SizedBox(height: Styles.space_m.bottom)
        ]);
      } else {
        return Container();
      }
    });
  }
}
