import 'package:flutter/cupertino.dart';
import 'package:mirror_wall/model/connect_model.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityProvider extends ChangeNotifier {
  Connectivity connectivity = Connectivity();

  ConnectivityModel connectivityModel = ConnectivityModel(status: "Waiting");


  checkInternetConnectivity() {
    connectivityModel.stream = connectivity.onConnectivityChanged
        .listen((ConnectivityResult connectivityResult) {
      switch (connectivityResult) {
        case ConnectivityResult.wifi:
          connectivityModel.status = "wifi";
          notifyListeners();
          break;
        case ConnectivityResult.mobile:
          connectivityModel.status = "Mobile Data";
          notifyListeners();
          break;
        default:
          connectivityModel.status = "Waiting";
          notifyListeners();
          break;
      }
    });
  }
}
