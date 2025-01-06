import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class FloatingMessengerWidget extends StatelessWidget {
  const FloatingMessengerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: UniqueKey(),
      onPressed: () async {
        const String fbProtocolUrl = 'fb-messenger://user/103339591031213/';

        // const String fallbackUrl =
        //     'https://www.facebook.com/profile.php?id=100064059696173';

        try {
          final Uri fbBundleUri = Uri.parse(fbProtocolUrl);
          final bool canLaunchNatively = await canLaunchUrl(fbBundleUri);

          if (canLaunchNatively) {
            launchUrl(fbBundleUri);
          } else {
            await launchUrl(Uri.parse(fbProtocolUrl),
                mode: LaunchMode.externalApplication);
          }
        } catch (e) {
          // Handle this as you prefer
        }
      },
      backgroundColor: const Color(0xFF00B2FF),
      child: const FaIcon(
        FontAwesomeIcons.facebookMessenger,
        size: 30,
        // color: MasterColors.facebookMessengerIconColor,
      ),
    );
  }
}
