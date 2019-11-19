class Event {
  final String clientMsgId;
  final String type;
  final String text;
  final String user;
  final String ts;
  final String team;
  final String channel;
  final String eventTs;

  Event.fromJson(Map<String, dynamic> jsonEvent)
      : clientMsgId = jsonEvent["client_msg_id"],
        type = jsonEvent["type"],
        text = jsonEvent["text"],
        user = jsonEvent["user"],
        ts = jsonEvent["ts"],
        team = jsonEvent["team"],
        channel = jsonEvent["channel"],
        eventTs = jsonEvent["event_ts"];
}
