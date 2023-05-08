import 'dart:async';

class ConnectivityModel {
  String status;
 StreamSubscription? stream;

  ConnectivityModel({
    required this.status,
    this.stream,
});
}