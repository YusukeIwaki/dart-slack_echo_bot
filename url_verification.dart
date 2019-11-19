import 'dart:io';

class UrlVerification {
  final HttpResponse response;
  UrlVerification(this.response);

  Future handle(String challenge) async {
    await response
      ..statusCode = HttpStatus.ok
      ..write(challenge);
  }
}
