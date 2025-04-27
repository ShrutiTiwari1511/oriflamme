import 'package:flutter/material.dart';
import 'package:oriflamme/views/caption/edit_caption_screen.dart';
import 'package:oriflamme/views/home/home_screen.dart';
import 'package:oriflamme/views/splash/splash_screen.dart';

class Routes {
  static const String splash = '/';
  static const String home = '/home';
  static const String editCaption = '/edit-caption';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      splash: (context) => const SplashScreen(),
      home: (context) => const HomeScreen(),
    };
  }

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case editCaption:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => EditCaptionScreen(
            initialCaption: args['initialCaption'],
            initialHashtag: args['initialHashtag'],
            initialReferral: args['initialReferral'],
            onSave: args['onSave'], id: '1',
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
    }
  }
}
