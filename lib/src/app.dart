import 'package:flutter/material.dart';
import 'config/size_config.dart';
import 'splash.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import './localization/demo_localization.dart';
import './localization/localization_value.dart';

class App extends StatefulWidget{
  static void setLocale(BuildContext context, Locale locale){
    _AppState state = context.findAncestorStateOfType<_AppState>();
    state.setLocale(locale);
  }
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  Locale _locale;
  void setLocale(Locale locale){
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((value){
      setState(() {
        this._locale = value;
      });
    });
    super.didChangeDependencies();
  }
  Widget build(context){
    return LayoutBuilder(
      builder: (context, constraints){
        return OrientationBuilder(
          builder: (context, orientation){
            SizeConfig().init(constraints, orientation);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Covid-19',
              home: Splash(),
              locale: _locale,
              supportedLocales: [
                Locale('en', 'US'),
                Locale('am', 'ETH')
              ],
              localizationsDelegates: [
                DemoLocalization.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              localeResolutionCallback: (deviceLocale, supportedLocales){
                for(var locale in supportedLocales){
                  if(locale.languageCode == deviceLocale.languageCode && locale.countryCode == deviceLocale.countryCode){
                    return deviceLocale;
                  }
                }
                return supportedLocales.first;
              },
            );
          },
        );
      },
    );
  }
}

