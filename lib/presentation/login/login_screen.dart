import 'package:assets_mobile/data/models/auth_state.dart';
import 'package:assets_mobile/data/models/cutom_error.dart';
import 'package:assets_mobile/presentation/login/provider/login_provider.dart';
import 'package:assets_mobile/presentation/splash/provider/splash_provider.dart';
import 'package:assets_mobile/presentation/widgets/button_widget.dart';
import 'package:assets_mobile/presentation/widgets/custom_formfield_widget.dart';
import 'package:assets_mobile/presentation/widgets/loading_screen_widget.dart';
import 'package:assets_mobile/route/route_name.dart';
import 'package:assets_mobile/route/route_provider.dart';
import 'package:assets_mobile/utils/app_assets.dart';
import 'package:assets_mobile/utils/app_colors.dart';
import 'package:assets_mobile/utils/app_dialog.dart';
import 'package:assets_mobile/utils/app_print.dart';
import 'package:assets_mobile/utils/app_text_Style.dart';
import 'package:assets_mobile/utils/extenstion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _usernameC = TextEditingController();
  final _passwordC = TextEditingController();

  @override
  void dispose() {
    _usernameC.dispose();
    _passwordC.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final obsecurePassword = ref.watch(obsecurePasswordProvider);
    final versi = ref.watch(versiProvider);
    final server = ref.watch(serverProvider);
    final isDemo = ref.watch(isDemoProvider);
    final getConList = ref.watch(getConListProvider);

    ref.listen<AuthState>(loginProvider, (previous, next) {
      AppPrint.debugLog("NEXXTT: $next");

      switch (next.status) {
        case AuthStatus.failure:
          AppDialog.errorDialog(
              context, (next.error).errorMessage, () => context.pop());
          break;
        case AuthStatus.success:
          ref.read(routerProvider).go(RouteName.main);
          break;
        default:
      }
    });

    return Scaffold(
      body: Form(
        key: _formKey,
        child: Stack(
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AppAssets.backgroundImage),
                    fit: BoxFit.cover),
              ),
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: 90.0.percentageWidth(context),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 12),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 18),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white),
                          child: Center(
                            child: Column(
                              children: [
                                Image.asset(
                                  !isDemo
                                      ? AppAssets.logoAdr
                                      : AppAssets.logoImage,
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.17,
                                  fit: BoxFit.cover,
                                ),
                                Text(
                                  "LOGIN",
                                  style: AppTextStyle.titleTextStyle.copyWith(
                                    color: Colors.black,
                                    fontSize: 48,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                10.h,
                                CustomFormfieldWidget(
                                  controller: _usernameC,
                                  conditionColor: false,
                                  outlineBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                      color: AppColors.textDisableColor,
                                    ),
                                  ),
                                  labelStyle:
                                      AppTextStyle.commonTextStyle.copyWith(
                                    color: AppColors.borderColor,
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.person,
                                    size: 18,
                                    color: AppColors.borderColor,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Username tidak boleh kosong";
                                    }
                                    return null;
                                  },
                                  label: "Username",
                                ),
                                15.h,
                                CustomFormfieldWidget(
                                  controller: _passwordC,
                                  conditionColor: true,
                                  outlineBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                      color: AppColors.textDisableColor,
                                    ),
                                  ),
                                  labelStyle:
                                      AppTextStyle.commonTextStyle.copyWith(
                                    color: AppColors.borderColor,
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.person,
                                    size: 18,
                                    color: AppColors.borderColor,
                                  ),
                                  isPassword: true,
                                  isObsecure: obsecurePassword,
                                  label: "Password",
                                  suffixIcon: IconButton(
                                      onPressed: () => ref
                                          .read(loginProvider.notifier)
                                          .changeObsecure(),
                                      icon: Icon(obsecurePassword
                                          ? Icons.visibility
                                          : Icons.visibility_off)),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Password tidak boleh kosong";
                                    }
                                    return null;
                                  },
                                ),
                                20.h,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text("Server",
                                        style: AppTextStyle.subTitleTextStyle
                                            .copyWith(
                                          color: Colors.black,
                                        )),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    getConList.when(
                                      data: (data) {
                                        AppPrint.debugLog("dropdown: $data");
                                        return Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                              border: Border.all(
                                                  color: AppColors.borderColor,
                                                  width: 1),
                                              color: Colors.white),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton<
                                                Map<String, dynamic>>(
                                              isExpanded: true,
                                              // Step 3.
                                              value: server.isNotEmpty
                                                  ? server
                                                  : data.first,
                                              // Step 4.
                                              items: data.map<
                                                      DropdownMenuItem<
                                                          Map<String,
                                                              dynamic>>>(
                                                  (Map<String, dynamic> value) {
                                                return DropdownMenuItem<
                                                    Map<String, dynamic>>(
                                                  value: value,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 5,
                                                        horizontal: 5),
                                                    child: Row(
                                                      children: [
                                                        const Icon(
                                                          Icons.storage,
                                                          size: 22,
                                                          color: Colors.black87,
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            value["label"],
                                                            overflow:
                                                                TextOverflow
                                                                    .fade,
                                                            maxLines: 1,
                                                            softWrap: false,
                                                            style: AppTextStyle
                                                                .subTitleTextStyle
                                                                .copyWith(),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                              // Step 5.
                                              onChanged: (newValue) {
                                                setState(() {
                                                  ref
                                                      .read(serverProvider
                                                          .notifier)
                                                      .update(
                                                          (state) => newValue!);
                                                });
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                      error: (error, stackTrace) => Center(
                                        child: Column(
                                          children: [
                                            Text((error as CustomError)
                                                .errorMessage),
                                            5.h,
                                            ButtonReusableWidget(
                                                onPressed: () {
                                                  ref.invalidate(
                                                      getConListProvider);
                                                },
                                                title: "Get Server"),
                                          ],
                                        ),
                                      ),
                                      loading: () => const Text(
                                        "Loading get database...",
                                      ),
                                    ),
                                  ],
                                ),
                                25.h,
                                ButtonReusableWidget(
                                    disabled: ref.watch(loginProvider).status ==
                                            AuthStatus.loading ||
                                        server.isEmpty,
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        ref.read(loginProvider.notifier).signIn(
                                            _usernameC.text,
                                            _passwordC.text,
                                            server["value"]);
                                      }
                                    },
                                    title: ref.watch(loginProvider).status ==
                                            AuthStatus.loading
                                        ? "Loading..."
                                        : "Login"),
                                20.h,
                                Text(
                                  "Version $versi",
                                  style: AppTextStyle.commonTextStyle,
                                ),
                                20.h,
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        // if (isPublic) {
                                        //   toast(context, "toast", "Connected to Public IP");
                                        // } else {
                                        //   toast(context, "toast", "Connected to Local IP");
                                        // }
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // isPublic
                                          //     ? Icon(
                                          //         Icons.wifi,
                                          //         color: Colors.green,
                                          //       )
                                          //     : Icon(
                                          //         Icons.wifi_off,
                                          //         color: Colors.blue,
                                          //       ),
                                          const Icon(
                                            Icons.wifi_off,
                                            color: Colors.blue,
                                          ),
                                          10.w,
                                          Text(
                                            "By IT Sub Division\nCopyright (c) ${DateFormat("yyyy").format(DateTime.now())} ADR Group of Companies",
                                            textAlign: TextAlign.center,
                                            style: AppTextStyle.commonTextStyle,
                                          ),
                                          const SizedBox(
                                            width: 2,
                                          ),
                                          Icon(
                                            Icons.wifi,
                                            color: Colors.white.withOpacity(0),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (ref.watch(loginProvider).status == AuthStatus.loading)
              const LoadingScreenWidget()
          ],
        ),
      ),
    );
  }
}
