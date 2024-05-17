import 'package:assets_mobile/data/models/auth_state.dart';
import 'package:assets_mobile/presentation/login/provider/login_provider.dart';
import 'package:assets_mobile/presentation/profile/provider/profile_provider.dart';
import 'package:assets_mobile/presentation/widgets/background_image_image.dart';
import 'package:assets_mobile/presentation/widgets/button_widget.dart';
import 'package:assets_mobile/presentation/widgets/custom_appbar_widget.dart';
import 'package:assets_mobile/presentation/widgets/custom_formfield_widget.dart';
import 'package:assets_mobile/repositories/auth/provider/auth_repository_provider.dart';
import 'package:assets_mobile/route/route_name.dart';
import 'package:assets_mobile/route/route_provider.dart';
import 'package:assets_mobile/utils/app_colors.dart';
import 'package:assets_mobile/utils/app_dialog.dart';
import 'package:assets_mobile/utils/app_text_Style.dart';
import 'package:assets_mobile/utils/extenstion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final _newPass = TextEditingController();
  final _confirmNewPass = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _newPass.dispose();
    _confirmNewPass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final username = ref.watch(usernameProvider);
    final email = ref.watch(emailProvider);
    final versi = ref.watch(versiProvider);

    return Scaffold(
      appBar: CustomAppbarWidget(
        isCenter: true,
        title: "Profile",
        titleStye: AppTextStyle.subTitleTextStyle.copyWith(fontWeight: FontWeight.w700, color: Colors.white),
      ),
      body: Stack(
        children: [
          const BackgroundImageWidget(),
          SafeArea(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Full Name:"),
                              3.h,
                              Text(username),
                              10.h,
                              const Text("Email:"),
                              3.h,
                              Text(email.isEmpty ? "-" : email),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ButtonReusableWidget(
                        onPressed: () async {
                          AppDialog.customDialog(
                            context,
                            "",
                            title: Text(
                              "Change Password",
                              style: AppTextStyle.subTitleTextStyle.copyWith(),
                            ),
                            content: Form(
                              key: _formKey,
                              child: Consumer(
                                builder: (_, ref, __) {
                                  final obsecureNewPassword = ref.watch(obsecureNewPasswordProvider);
                                  final obsecureNewConfirmPassword = ref.watch(obsecureNewConfirmPasswordProvider);
                                  final status = ref.watch(changePasswordProvider).status;

                                  ref.listen<AuthState>(changePasswordProvider, (previous, next) {
                                    switch (next.status) {
                                      case AuthStatus.failure:
                                        AppDialog.errorDialog(context, (next.error).errorMessage, () => context.pop());
                                        break;
                                      case AuthStatus.success:
                                        ref.read(routerProvider).pop();
                                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Successfully change password!')));
                                        break;
                                      default:
                                    }
                                  });

                                  return SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.6,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        CustomFormfieldWidget(
                                          controller: _newPass,
                                          conditionColor: false,
                                          label: "New Password",
                                          enabled: status != AuthStatus.loading,
                                          labelStyle: AppTextStyle.commonTextStyle.copyWith(color: AppColors.textDisableColor),
                                          isObsecure: obsecureNewPassword,
                                          isPassword: true,
                                          suffixIcon: IconButton(
                                              onPressed: () => ref.read(obsecureNewPasswordProvider.notifier).update((state) => !state),
                                              icon: Icon(obsecureNewPassword ? Icons.visibility : Icons.visibility_off)),
                                        ),
                                        5.h,
                                        CustomFormfieldWidget(
                                          conditionColor: false,
                                          controller: _confirmNewPass,
                                          label: "Confirm New Password",
                                          enabled: status != AuthStatus.loading,
                                          labelStyle: AppTextStyle.commonTextStyle.copyWith(color: AppColors.textDisableColor),
                                          isObsecure: obsecureNewConfirmPassword,
                                          isPassword: true,
                                          suffixIcon: IconButton(
                                              onPressed: () => ref.read(obsecureNewConfirmPasswordProvider.notifier).update((state) => !state),
                                              icon: Icon(obsecureNewConfirmPassword ? Icons.visibility : Icons.visibility_off)),
                                        ),
                                        10.h,
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            ButtonReusableWidget(
                                              onPressed: () => context.pop(),
                                              title: "Cancel",
                                              backgroundColor: Colors.red,
                                              width: 150,
                                            ),
                                            17.w,
                                            Expanded(
                                              child: ButtonReusableWidget(
                                                onPressed: () {
                                                  ref.read(changePasswordProvider.notifier).callChange(_newPass.text);
                                                },
                                                disabled: status == AuthStatus.loading,
                                                title: status == AuthStatus.loading ? "Loading..." : "Change",
                                                width: 150,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                            actions: [],
                          );
                        },
                        title: "Change Password"),
                    10.h,
                    ButtonReusableWidget(
                        onPressed: () async {
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
                                                _confirmNewPass.clear();
                                                _newPass.clear();
                                                ref.invalidate(obsecureNewConfirmPasswordProvider);
                                                ref.invalidate(obsecureNewPasswordProvider);
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
                        title: "Logout"),
                    const SizedBox(
                      height: 56,
                    ),
                    InkWell(
                      onTap: () async => await ref.read(authRepositoryProvider).refreshToken(),
                      child: Center(
                          child: Text(
                        "App Version $versi",
                        style: AppTextStyle.subTitleTextStyle.copyWith(color: Colors.white),
                      )),
                    )
                  ],
                ),
              )
            ],
          )),
        ],
      ),
    );
  }
}
