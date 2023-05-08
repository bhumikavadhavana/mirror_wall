import 'package:flutter/material.dart';
import 'package:mirror_wall/views/screens/homepage.dart';
import 'package:provider/provider.dart';
import 'package:mirror_wall/controller/provider/connect_provider.dart';
import 'package:mirror_wall/model/connect_model.dart';

void main() {
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => ConnectivityProvider(),
          ),
        ],
        builder: (context, _) {
          return MaterialApp(
            theme: ThemeData(
              useMaterial3: true,
            ),
            debugShowCheckedModeBanner: false,
            routes: {
              '/': (context) => HomePage(),
            },
          );
        }),
  );
}
