import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plant_shop/models/repository.dart';
import 'package:plant_shop/screens/HomeScreen/HomeBloc.dart';
import 'package:plant_shop/screens/HomeScreen/HomeBlocScreen.dart';
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
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Plant Shop',
        theme: ThemeData(
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          fontFamily: GoogleFonts.lato().fontFamily,
          accentColor: HexColor("20B25D"),
        ),
        home: HomeScreen(),
      ),
    );
  }
}
