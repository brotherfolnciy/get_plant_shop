import 'package:flutter/material.dart';
import 'package:plant_shop/screens/AuthenticationScreen/AuthenticationBloc.dart';
import 'package:plant_shop/widgets/AuthenticationPage/authentication_page_input_field.dart';
import 'package:provider/provider.dart';

class AuthenticationPageLoginForm extends StatefulWidget {
  AuthenticationPageLoginForm({Key? key}) : super(key: key);

  @override
  _AuthenticationPageLoginFormState createState() =>
      _AuthenticationPageLoginFormState();
}

class _AuthenticationPageLoginFormState
    extends State<AuthenticationPageLoginForm> {
  late AuthenticationBloc authenticationBloc;
  late String loginEmail = '';
  late String loginPassword = '';

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationBloc>(
      builder: (context, _authenticationBloc, child) {
        authenticationBloc = _authenticationBloc;
        return getLogInForm();
      },
    );
  }

  Container getLogInForm() {
    return Container(
      padding: EdgeInsets.all(25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AuthenticationPageInputField(
            hintText: 'E-mail',
            onEditing: (text) {
              loginEmail = text;
            },
            lettersOnly: false,
            obscureText: false,
          ),
          SizedBox(
            height: 15,
          ),
          AuthenticationPageInputField(
            hintText: 'Password',
            onEditing: (text) {
              loginPassword = text;
            },
            lettersOnly: false,
            obscureText: true,
          ),
          SizedBox(
            height: 25,
          ),
          ElevatedButton(
            onPressed: () {
              authenticationBloc.signInWithEmailAndPassword(
                  loginEmail, loginPassword);
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 17.5,
              ),
              child: Text(
                "Log in".toUpperCase(),
                style: TextStyle(fontSize: 18),
              ),
            ),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              authenticationBloc
                  .setCurrentState(AuthenticationBlocStates.register);
            },
            child: Container(
              child: Text(
                "Register".toUpperCase(),
                style: TextStyle(
                  shadows: [
                    Shadow(
                      color: Colors.white,
                      offset: Offset(0, -2.5),
                    )
                  ],
                  color: Colors.transparent,
                  fontSize: 14,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.white,
                  decorationThickness: 1,
                ),
              ),
            ),
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all<Color>(Colors.white12),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
