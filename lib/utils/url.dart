import 'package:url_launcher/url_launcher.dart';

launchUrl(url) async {
  if (await canLaunch(url)) {
    await launch(url, forceSafariVC: false);
  } else {
    throw 'Could not launch $url';
  }
}
