import 'package:assets_mobile/utils/app_assets.dart';
import 'package:flutter/material.dart';

class BackgroundImageWidget extends StatelessWidget {
  const BackgroundImageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(AppAssets.backgroundImage), fit: BoxFit.cover),
      ),
    );
  }
}
