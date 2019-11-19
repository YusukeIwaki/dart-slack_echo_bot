import 'dart:io';
import 'package:args/args.dart';

import './webhook.dart';

class CliOptions {
  final ArgResults parsedArgs;
  CliOptions.parse(List<String> args)
      : this.parsedArgs = (ArgParser()
              ..addFlag("localhost", defaultsTo: true)
              ..addOption("port", abbr: "p"))
            .parse(args);

  InternetAddress bindAddress() {
    if (parsedArgs["localhost"]) {
      return InternetAddress.loopbackIPv4;
    } else {
      return InternetAddress.anyIPv4;
    }
  }

  int port() {
    if (parsedArgs["port"] == null) {
      return 4000;
    }
    return int.parse(parsedArgs["port"]);
  }
}

Future main(List<String> args) async {
  final options = CliOptions.parse(args);

  HttpServer server = await HttpServer.bind(
    options.bindAddress(),
    options.port(),
  );
  print("Listening on ${options.bindAddress().address}:${options.port()}...");

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
