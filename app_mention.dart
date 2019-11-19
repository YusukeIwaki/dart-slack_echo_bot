import 'package:http/http.dart' as http;

import './credentials.dart';
import './event.dart';

class AppMention {
  final Event event;
  AppMention(this.event);

  Future handle() async {
    // https://api.slack.com/methods/chat.postMessage
    final String url = "https://slack.com/api/chat.postMessage";
    await http.post(url, body: {
      "token": BOT_USER_TOKEN,
      "channel": event.channel,
      "text": _text(),
      "thread_ts": event.ts,
    });
  }

  String _text() {
    return "Hi <@${event.user}>, how are you?";
  }
}
