import 'package:flutter/material.dart';
import 'package:keyboard_service/keyboard_service.dart';
import 'package:plant_shop/screens/AuthenticationScreen/AuthenticationBloc.dart';
import 'package:plant_shop/widgets/AuthenticationPage/authentication_page_input_field.dart';
import 'package:provider/provider.dart';

class AuthenticationPageRegisterForm extends StatefulWidget {
  AuthenticationPageRegisterForm({Key? key}) : super(key: key);

  @override
  _AuthenticationPageRegisterFormState createState() =>
      _AuthenticationPageRegisterFormState();
}

class _AuthenticationPageRegisterFormState
    extends State<AuthenticationPageRegisterForm> {
  late AuthenticationBloc authenticationBloc;
  late String registrationEmail = '';
  late String registrationPassword = '';
  late String registrationConfirmPassword = '';
  late bool keyboardIsShow = false;

  @override
  Widget build(BuildContext context) {
    keyboardIsShow = KeyboardService.isVisible(context);
    return Consumer<AuthenticationBloc>(
      builder: (context, _authenticationBloc, child) {
        authenticationBloc = _authenticationBloc;
        return getRegisterForm();
      },
    );
  }

  Container getRegisterForm() {
    return Container(
      child: Column(
        children: [
          Flexible(
            flex: 5,
            child: Container(
              padding: EdgeInsets.all(25),
              child: Column(
                children: [
                  AuthenticationPageInputField(
                    hintText: 'Enter Your E-mail',
                    onEditing: (text) {
                      registrationEmail = text;
                    },
                    lettersOnly: false,
                    obscureText: false,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  AuthenticationPageInputField(
                    hintText: 'Enter password',
                    onEditing: (text) {
                      registrationPassword = text;
                    },
                    lettersOnly: false,
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  AuthenticationPageInputField(
                    hintText: 'Confirm password',
                    onEditing: (text) {
                      registrationConfirmPassword = text;
                    },
                    lettersOnly: false,
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (registrationConfirmPassword == registrationPassword)
                        authenticationBloc.registeredWithEmailAndPassword(
                            registrationEmail.toString().trim(),
                            registrationPassword.toString().trim());
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 17.5,
                      ),
                      child: Text(
                        "Register".toUpperCase(),
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  !keyboardIsShow
                      ? TextButton(
                          onPressed: () {
                            authenticationBloc.setCurrentState(
                                AuthenticationBlocStates.signOut);
                          },
                          child: Container(
                            child: Text(
                              "back to login".toUpperCase(),
                              style: TextStyle(
                                shadows: [
                                  Shadow(
                                    color: Colors.white,
                                    offset: Offset(0, -2.5),
                                  )
                                ],
                                color: Colors.transparent,
                                fontSize: 12,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.white,
                                decorationThickness: 1,
                              ),
                            ),
                          ),
                          style: ButtonStyle(
                            overlayColor: MaterialStateProperty.all<Color>(
                                Colors.white12),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
