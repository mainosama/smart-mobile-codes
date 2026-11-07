import 'package:url_launcher/url_launcher.dart';

class DialerService {
  Future<bool> dial(String rawCode) async {
    // Keep digits, * and #. URI encoding is handled by Uri.
    final code = rawCode.replaceAll(RegExp(r'[^0-9*#]'), '');
    if (code.isEmpty) return false;
    final uri = Uri(scheme: 'tel', path: code);
    return launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
