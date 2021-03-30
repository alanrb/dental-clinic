import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'src/authentication.dart';
import 'src/models/app_state_model.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => ApplicationState(),
    builder: (context, _) => App(),
  ));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dental Clinic',
      theme: ThemeData(
          buttonTheme: Theme.of(context)
              .buttonTheme
              .copyWith(highlightColor: Colors.greenAccent),
          primarySwatch: Colors.green,
          textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme),
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dental Clinic'),
        actions: <Widget>[
          Consumer<ApplicationState>(
            builder: (context, appState, _) => _buildAppbarActions(context, appState),
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Image.asset('assets/dental_clinic.jpg'),
          SizedBox(height: 8),
          Consumer<ApplicationState>(
              builder: (context, appState, _) => Authentication(
                  loginState: appState.loginState,
                  email: appState.email,
                  startLoginFlow: appState.startLoginFlow,
                  verifyEmail: appState.verifyEmail,
                  signInWithEmailAndPassword:
                      appState.signInWithEmailAndPassword,
                  cancelRegistration: appState.cancelRegistration,
                  registerAccount: appState.registerAccount,
                  signOut: appState.signOut)),
        ],
      ),
      floatingActionButton: Consumer<ApplicationState>(
        builder: (context, appState, _) => FloatingActionButton.extended(
            onPressed: () => _makeAppointment(context, appState),
            label: Text('Appointment'),
            icon: Icon(Icons.calendar_today_outlined)),
      ),
    );
  }

  void _makeAppointment(BuildContext context, ApplicationState appState) {
    if (appState.loginState == ApplicationLoginState.loggedIn) {
      Navigator.of(context).push(MaterialPageRoute<void>(
          builder: (context) => MakeAppointmentDialog(),
          fullscreenDialog: true));
    } else {}
  }
}

Widget _buildAppbarActions(BuildContext context, ApplicationState appState) {
  if (appState.loginState == ApplicationLoginState.loggedIn) {
    return IconButton(
        icon: Icon(Icons.logout),
        onPressed: () => {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text('Logout'),
                        content: Text(
                            'Are you sure you want to logout?'),
                        actions: [
                          TextButton(
                            onPressed: () {},
                            child: Text('Remain Signed In'),
                          ),
                          TextButton(
                            onPressed: () {
                              appState.signOut();
                            },
                            child: Text('Yes, Logout'),
                          ),
                        ],
                      ))
            });
  } else {
    return Container();
  }
}

class MakeAppointmentDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Make Appointment'),
      ),
      body: Center(
        child: Text('Appointment form'),
      ),
    );
  }
}
