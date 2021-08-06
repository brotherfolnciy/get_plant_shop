import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyboard_service/keyboard_service.dart';
import 'package:plant_shop/screens/AuthenticationScreen/AuthenticationBloc.dart';
import 'package:plant_shop/widgets/AuthenticationPage/authentication_page_input_field.dart';
import 'package:plant_shop/widgets/AuthenticationPage/authentication_page_login_form.dart';
import 'package:plant_shop/widgets/AuthenticationPage/authentication_page_register_form.dart';
import 'package:provider/provider.dart';

class AuthentificationScreen extends StatefulWidget {
  AuthentificationScreen({Key? key}) : super(key: key);

  @override
  _AuthentificationScreenState createState() => _AuthentificationScreenState();
}

class _AuthentificationScreenState extends State<AuthentificationScreen> {
  late AuthenticationBloc authentificationBloc;
  final ValueNotifier<String> emailValueNotifier = ValueNotifier<String>("");
  final ValueNotifier<String> passwordValueNotifier = ValueNotifier<String>("");
  final PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardAutoDismiss(
      scaffold: Scaffold(
        backgroundColor: Theme.of(context).cardColor,
        resizeToAvoidBottomInset: true,
        body: getBody(),
      ),
    );
  }

  Widget getBody() {
    return Consumer<AuthenticationBloc>(
      builder: (context, authentificationBloc, child) {
        this.authentificationBloc = authentificationBloc;
        return Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/Plant.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment
                      .bottomCenter, // 10% of the width, so there are ten blinds.
                  colors: <Color>[
                    Colors.black54,
                    Colors.transparent
                  ], // red to yellow
                  tileMode:
                      TileMode.repeated, // repeats the gradient over the canvas
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 3,
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          Text(
                            'Bring Nature\nInto Your Home',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.playfairDisplay(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 38,
                            ),
                          ),
                          SizedBox(
                            height: 7.5,
                          ),
                          Text(
                            'With Our Plants',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.playfairDisplay(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 4,
                    child: Container(
                      alignment: Alignment.center,
                      child: StreamBuilder<AuthenticationBlocStates>(
                        stream: authentificationBloc.currentState,
                        initialData: AuthenticationBlocStates.signOut,
                        builder: (context, snapshot) {
                          AuthenticationBlocStates? currentAuthenticationState =
                              snapshot.hasData
                                  ? snapshot.data
                                  : AuthenticationBlocStates.offline;
                          if (currentAuthenticationState ==
                              AuthenticationBlocStates.offline) {
                            return getOfflineForm();
                          } else if (currentAuthenticationState ==
                              AuthenticationBlocStates.enter) {
                            return Container();
                          }
                          switch (currentAuthenticationState) {
                            case AuthenticationBlocStates.signOut:
                              if (pageController.hasClients)
                                pageController.animateToPage(0,
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.easeOutQuart);
                              break;
                            case AuthenticationBlocStates.register:
                              if (pageController.hasClients)
                                pageController.animateToPage(1,
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.easeOutQuart);
                              break;
                            default:
                              break;
                          }
                          return PageView(
                            controller: pageController,
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                              AuthenticationPageLoginForm(),
                              AuthenticationPageRegisterForm(),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Container getOfflineForm() {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.symmetric(horizontal: 35, vertical: 75),
      child: ElevatedButton(
        onPressed: () {
          authentificationBloc.checkInternetConnection();
        },
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(5),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 17.5),
          child: Container(
            child: Text(
              'Unable to connect to the internet',
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
