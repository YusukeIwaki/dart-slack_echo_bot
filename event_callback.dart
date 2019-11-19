import 'dart:io';

import './event.dart';
import './app_mention.dart';

class EventCallback {
  final HttpResponse response;
  EventCallback(this.response);

  Future handle(Event event) async {
    if (event.type == "app_mention") {
      await AppMention(event).handle();
    }

    await response
      ..statusCode = HttpStatus.ok
      ..write("OK");
  }
}
