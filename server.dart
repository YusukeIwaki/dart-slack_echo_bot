import 'dart:io';

import './webhook.dart';

Future main() async {
  HttpServer server = await HttpServer.bind(
    InternetAddress.anyIPv4,
    4000,
  );
  print("Listening on ${InternetAddress.anyIPv4.address}:4000...");

  await for (HttpRequest request in server) {
    try {
      await Webhook(request).handle();
    } catch (e) {
      print(e);
      request.response
        ..statusCode = HttpStatus.internalServerError
        ..write("Exception: $e");
    }
    await request.response.close();
  }
}
