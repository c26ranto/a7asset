import 'package:assets_mobile/data/models/auth_state.dart';
import 'package:assets_mobile/presentation/login/provider/login_provider.dart';
import 'package:assets_mobile/presentation/profile/provider/profile_provider.dart';
import 'package:assets_mobile/presentation/widgets/button_widget.dart';
import 'package:assets_mobile/route/route_name.dart';
import 'package:assets_mobile/route/route_provider.dart';
import 'package:assets_mobile/utils/app_assets.dart';
import 'package:assets_mobile/utils/app_colors.dart';
import 'package:assets_mobile/utils/app_dialog.dart';
import 'package:assets_mobile/utils/app_text_Style.dart';
import 'package:assets_mobile/utils/extenstion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DrawerItemWidget extends ConsumerWidget {
  const DrawerItemWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userName = ref.watch(usernameProvider);

    final drawerHeader = UserAccountsDrawerHeader(
      onDetailsPressed: () {
        Navigator.pop(context);
        context.push(RouteName.profile);
      },
      // <-- SEE HERE
      decoration: const BoxDecoration(color: AppColors.appBarColor),
      accountName: Text(
        userName,
        style: AppTextStyle.commonTextStyle.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
      ),
      accountEmail: Text(
        userName,
        style: AppTextStyle.commonTextStyle.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
      ),
      currentAccountPicture: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
              context.push(RouteName.profile);
            },
            child: CircleAvatar(radius: 30, backgroundImage: const AssetImage(AppAssets.userImage), backgroundColor: Colors.black.withOpacity(0)),
          ),
        ],
      ),
    );

    return Column(
      children: [
        Expanded(
          flex: 1,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              drawerHeader,
              ListTile(
                textColor: Colors.black,
                horizontalTitleGap: 0,
                trailing: const Icon(
                  Icons.chevron_right,
                  color: Colors.black,
                ),
                leading: const Icon(
                  Icons.fact_check,
                  color: Colors.black,
                ),
                title: const Text(
                  'CHECKLIST MAINTENANCE',
                  style: AppTextStyle.subTitleTextStyle,
                ),
                onTap: () {
                  Navigator.pop(context);
                  context.push(RouteName.chooseShift);
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(height: 1, width: double.infinity, color: Colors.blueGrey[200]),
              ),
              ListTile(
                textColor: Colors.black,
                horizontalTitleGap: 0,
                trailing: const Icon(
                  Icons.chevron_right,
                  color: Colors.black,
                ),
                leading: const Icon(
                  Icons.fact_check,
                  color: Colors.black,
                ),
                title: const Text(
                  'CHECKLIST VERIFICATION',
                  style: AppTextStyle.subTitleTextStyle,
                ),
                onTap: () {
                  // Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SizedBox()));
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(height: 1, width: double.infinity, color: Colors.blueGrey[200]),
              ),
              ListTile(
                textColor: Colors.black,
                horizontalTitleGap: 0,
                trailing: const Icon(
                  Icons.chevron_right,
                  color: Colors.black,
                ),
                leading: const Icon(
                  Icons.fact_check,
                  color: Colors.black,
                ),
                title: const Text(
                  'CHECKLIST MAINTENANCE INFO',
                  style: AppTextStyle.subTitleTextStyle,
                ),
                onTap: () {
                  Navigator.pop(context);
                  context.push(RouteName.checklistHistory);
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(height: 1, width: double.infinity, color: Colors.blueGrey[200]),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () async {
            AppDialog.customDialog(
              context,
              "",
              title: Text(
                "Logout",
                style: AppTextStyle.subTitleTextStyle.copyWith(
                  color: Colors.black,
                ),
              ),
              content: Consumer(
                builder: (_, ref, __) {
                  final status = ref.watch(logoutProvider).status;

                  ref.listen<AuthState>(logoutProvider, (previous, next) {
                    switch (next.status) {
                      case AuthStatus.failure:
                        context.pop();
                        AppDialog.errorDialog(context, (next.error).errorMessage, () => context.pop());
                        break;
                      case AuthStatus.success:
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Successfully change password!')));
                        ref.read(routerProvider).pop();
                        ref.read(routerProvider).go(RouteName.login);
                        break;
                      default:
                    }
                  });

                  return SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Are you sure wanna logout?",
                          style: AppTextStyle.commonTextStyle.copyWith(),
                        ),
                        10.h,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: ButtonReusableWidget(
                                onPressed: () {
                                  // _confirmNewPass.clear();
                                  // _newPass.clear();
                                  // ref.invalidate(obsecureNewConfirmPasswordProvider);
                                  // ref.invalidate(obsecureNewPasswordProvider);
                                  context.pop();
                                },
                                title: "Cancel",
                                backgroundColor: Colors.red,
                                height: 38,
                              ),
                            ),
                            10.w,
                            Expanded(
                              child: ButtonReusableWidget(
                                onPressed: () async {
                                  await ref.read(logoutProvider.notifier).callLogout();
                                },
                                disabled: status == AuthStatus.loading,
                                title: status == AuthStatus.loading ? "Loading..." : "Logout",
                                height: 38,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              actions: [],
            );
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(color: Colors.red, border: Border(top: BorderSide(color: Colors.black12, width: 1))),
            child: Row(
              children: [
                const Icon(Icons.logout, color: Colors.white),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  "Logout",
                  style: AppTextStyle.subTitleTextStyle.copyWith(color: Colors.white),
                ),
                const Expanded(
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.chevron_right,
                          color: Colors.white,
                        )))
              ],
            ),
          ),
        )
      ],
    );
  }
}
