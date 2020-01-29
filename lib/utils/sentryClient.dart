import 'package:sentry/sentry.dart';

class SentryClient {
  //  String dsn = "https://e2d7d8c5e32140c8b908dc11e837a940@sentry.io/2066660";
  // final SentryClient _sentry = new SentryClient(
  //     dsn:dsn );

  bool get isInDebugMode {
    // Assume you're in production mode.
    bool inDebugMode = false;

    // Assert expressions are only evaluated during development. They are ignored
    // in production. Therefore, this code only sets `inDebugMode` to true
    // in a development environment.
    assert(inDebugMode = true);

    return inDebugMode;
  }

  // Future<void> _reportError(dynamic error, dynamic stackTrace) async {
  //   // Print the exception to the console.
  //   print('Caught error: $error');
  //   if (isInDebugMode) {
  //     // Print the full stacktrace in debug mode.
  //     print(stackTrace);
  //     return;
  //   } else {
  //     // Send the Exception and Stacktrace to Sentry in Production mode.
  //     _sentry.captureException(
  //       exception: error,
  //       stackTrace: stackTrace,
  //     );
  //   }
  // }
}
