import 'package:assets_mobile/presentation/login/provider/login_provider.dart';
import 'package:assets_mobile/presentation/main/widgets/drawer_item_widget.dart';
import 'package:assets_mobile/presentation/splash/provider/splash_provider.dart';
import 'package:assets_mobile/presentation/widgets/custom_appbar_widget.dart';
import 'package:assets_mobile/utils/app_assets.dart';
import 'package:assets_mobile/utils/app_text_Style.dart';
import 'package:assets_mobile/utils/extenstion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final username = ref.watch(usernameProvider);
    final database = ref.watch(databaseProvider);
    final versi = ref.watch(versiProvider);
    final apiUrl = ref.watch(apiUrlProvider);
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      drawer: Drawer(
        width: !isPortrait ? MediaQuery.of(context).size.width * 0.5 : MediaQuery.of(context).size.width * 0.8,
        child: const DrawerItemWidget(),
      ),
      appBar: CustomAppbarWidget(
        isCenter: true,
        title: "ADR ASSET",
        titleStye: AppTextStyle.subTitleTextStyle.copyWith(fontWeight: FontWeight.w700, color: Colors.white),
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage(AppAssets.backgroundImage), fit: BoxFit.cover),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.checklist,
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Text("Welcome, $username", style: AppTextStyle.subTitleTextStyle.copyWith(color: Colors.black, fontWeight: FontWeight.w400))
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Column(
                            children: [
                              Image.asset(
                                "assets/images/login_logo.png",
                                width: 220,
                              ),
                            ],
                          ),
                        ],
                      )),
                  20.h,
                  Container(
                      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.info_rounded, size: 18),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  "Version: $versi",
                                  style: AppTextStyle.commonTextStyle,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              const Icon(Icons.storage, size: 18),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Text(
                                "Database : $database",
                                style: AppTextStyle.commonTextStyle,
                              )),
                            ],
                          ),
                          Visibility(
                              // visible: _infoToggle,
                              child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              children: [
                                const Icon(Icons.language_rounded, size: 18),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: Text(
                                  "API URL: $apiUrl",
                                  style: AppTextStyle.commonTextStyle,
                                )),
                              ],
                            ),
                          ))
                        ],
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
