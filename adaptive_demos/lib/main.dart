import 'package:adaptive_demos/app_model.dart';
import 'package:flutter/material.dart';
// import 'package:adaptive_app_demos/main_app_scaffold.dart';
// import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(AppScaffold());
  doWhenWindowReady((){
    appWindow.title = "Adaptive App Demo";
    appWindow.show();
});
}


class AppScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppModel>(
        create: (_) => AppModel(),
        child: Builder(builder: (context) {
          bool touchMode = context.select((AppModel m) => m.touchMode);
          double densityAmt = touchMode ? 0.0 : -1.0;
          VisualDensity density = VisualDensity(horizontal: densityAmt, vertical: densityAmt);
          return MaterialApp(
            theme: ThemeData(visualDensity: density),
            home: MainAppScaffold(),
            debugShowCheckedModeBanner: false,
          );
        }));
  }
}
