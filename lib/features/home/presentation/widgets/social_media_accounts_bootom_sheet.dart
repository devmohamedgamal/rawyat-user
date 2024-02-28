import 'package:flutter/Material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/functions/launch_url.dart';
import '../../../../core/utils/assets_manger.dart';

void socialMediaAccountsBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton.icon(
                  icon: const Icon(Icons.facebook),
                  onPressed: () {
                    customLaunchUrl(context,
                        'https://www.facebook.com/Eslam.Mahmoud1995?mibextid=AEUHqQ/');
                  },
                  label: const Text(
                    'Facebook',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                TextButton.icon(
                  icon: SvgPicture.asset(
                    AssetsManger.instaIcon,
                    height: 24,
                  ),
                  onPressed: () {
                    customLaunchUrl(context,
                        'https://www.instagram.com/eslam_mahmoud1995/');
                  },
                  label: const Text(
                    'Instagram',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                TextButton.icon(
                  icon: SvgPicture.asset(
                    AssetsManger.tiktokIcon,
                    height: 24,
                  ),
                  onPressed: () {
                    customLaunchUrl(context,
                        'https://www.tiktok.com/@eslammahmoud191?_t=8k5LINzw67S&_r=1');
                  },
                  label: const Text(
                    'TikTok',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                TextButton.icon(
                  icon: SvgPicture.asset(
                    AssetsManger.youtubeIcon,
                    height: 24,
                  ),
                  onPressed: () {
                    customLaunchUrl(context,
                        'https://youtube.com/@eslammahmoud1995?si=UXX_QeNh_-nkYRjE/');
                  },
                  label: const Text(
                    'Youtube',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          );
        });
  }