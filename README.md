# slack_echo_bot

![image](https://user-images.githubusercontent.com/11763113/69113481-76bb2500-0ac6-11ea-8684-f7b8a9005aa6.png)


## Integrate with Slack.

1. Add your own app. https://api.slack.com/apps
2. Set your app's verification token and bot user token, to credentials.dart.
3. Add Bot user for your app.
4. Enable event subscription for your app, with `app_mention` subscription in `Subscribe to bot events` section.
5. Install your app into your Slack workspace.

## build

Put your `credentials.dart` by copying `credentials.dart.sample`.

Then

```
dart2native server.dart -o ./slack_echo_bot
```

will generate a executable binary.

## deploy

Prepare a Linux based server.

Install nginx or another SSL-offloading (SSL -> localhost:4000) server.

Then just put `slack_echo_bot`, and execute it.
