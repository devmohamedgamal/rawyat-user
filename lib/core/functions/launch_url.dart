

import 'package:url_launcher/url_launcher.dart';

import '../utils/custom_snackbar.dart';

Future<void> customLaunchUrl(context, String? url) async {
  if (url != null) {
  Uri uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    customSnackBar(context, "Cannot launche $uri");
  }
}
}
