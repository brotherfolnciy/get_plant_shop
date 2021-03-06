import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plant_shop/models/repository.dart';
import 'package:plant_shop/screens/AuthenticationScreen/AuthenticationBloc.dart';
import 'package:plant_shop/screens/AuthenticationScreen/AuthenticationBlocScreen.dart';
import 'package:plant_shop/screens/BasketScreen/BasketBloc.dart';
import 'package:plant_shop/screens/HomeScreen/HomeBloc.dart';
import 'package:flutter/services.dart';
import 'package:plant_shop/screens/PlantInformationScreen/PlantInformationBloc.dart';
import 'package:provider/provider.dart';

void main() {
  runApp((MyApp()));
}

class MyApp extends StatelessWidget {
  final Repository repository = Repository();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    ColorScheme colorScheme = ColorScheme.light(
      brightness: Brightness.light,
      background: Colors.white,
      primary: HexColor("20B25D"),
    );
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Container();
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return MultiProvider(
            providers: [
              Provider<HomeBloc>(
                create: (_) => HomeBloc(repository: repository),
                dispose: (_, HomeBloc _homeBloc) => _homeBloc.dispose(),
              ),
              Provider<PlantInformationBloc>(
                create: (_) => PlantInformationBloc(repository: repository),
                dispose: (_, PlantInformationBloc _plantInformationBloc) =>
                    _plantInformationBloc.dispose(),
              ),
              Provider<BasketBloc>(
                create: (_) => BasketBloc(repository: repository),
                dispose: (_, BasketBloc _busketBLoc) => _busketBLoc.dispose(),
              ),
              Provider<AuthenticationBloc>(
                create: (_) => AuthenticationBloc(repository: repository),
                dispose: (_, AuthenticationBloc _authenticationBLoc) =>
                    _authenticationBLoc.dispose(),
              ),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'GetPlant',
              theme: ThemeData(
                fontFamily: GoogleFonts.lato().fontFamily,
                colorScheme: colorScheme,
                backgroundColor: Colors.white,
                cardColor: HexColor("F1F4FB"),
              ),
              home: AuthentificationScreen(),
            ),
          );
        }

        return Container(
          color: Colors.black,
        );
      },
    );
  }
}
