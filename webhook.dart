import 'dart:io';
import 'dart:convert';

import './credentials.dart';
import './event.dart';
import './event_callback.dart';
import './url_verification.dart';

class Webhook {
  final HttpRequest request;
  Webhook(this.request);

  Future handle() async {
    print("\n${request.method} ${request.uri}");
    print(request.headers);

    ContentType contentType = request.headers.contentType;
    if (request.method != 'POST' &&
        request.uri.path != '/echo' &&
        contentType.mimeType != 'application/json') {
      await request.response
        ..statusCode = HttpStatus.methodNotAllowed
        ..write("Only `POST /echo` is available");
      return;
    }

    String body = await utf8.decoder.bind(request).join();
    var jsonBody = jsonDecode(body);
    print(jsonBody);

    if (jsonBody["token"] != VERIFICATION_TOKEN) {
      await request.response
        ..statusCode = HttpStatus.unauthorized
        ..write("Invalid verification token.");
      return;
    }

    final String type = jsonBody["type"];
    if (type == "url_verification") {
      await UrlVerification(request.response).handle(jsonBody["challenge"]);
    } else if (type == "event_callback") {
      await EventCallback(request.response)
          .handle(Event.fromJson(jsonBody["event"]));
    } else {
      await request.response
        ..statusCode = HttpStatus.badRequest
        ..write("Unknown type: $type");
    }
  }
}
