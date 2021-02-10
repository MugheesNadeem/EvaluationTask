import 'dart:io';

Future<bool> checkConnection() async {
  bool connectivityCheck;
  try {
    final result = await InternetAddress.lookup('example.com')
        .timeout(const Duration(seconds: 20));
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print('connected');
      connectivityCheck = true;
    }
  } on SocketException catch (_) {
    print('not connected');
    connectivityCheck = false;
  }

  return connectivityCheck;
}