import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/ui/auth/login/login_navigator.dart';
import 'package:evently_app/ui/auth/login/login_screen_view_model.dart';
import 'package:evently_app/ui/home/taps/widgets/custom_elevated_button.dart';
import 'package:evently_app/ui/home/taps/widgets/custom_text_form_field.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_routes.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:evently_app/utils/dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utils/app_assets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> implements LoginNavigator{

  // TextEditingController emailController = TextEditingController(
  //   text: 'dounya@gmail.com',
  // );
  // TextEditingController passwordController = TextEditingController(
  //   text: '123456',
  // );

  bool isObscure = true;

  LoginScreenViewModel viewModel = LoginScreenViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.04,
              vertical: height * 0.03,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Form(
                    key: viewModel.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Image.asset(AppAssets.logo, height: height * 0.22),
                        SizedBox(height: height * 0.04),
                        CustomTextFormField(
                          prefixIcon: Image.asset(AppAssets.emailIcon),
                          hintText: AppLocalizations.of(context)!.email,
                          controller: viewModel.emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'Please enter email'; //todo: invalid
                            }
                            final bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                            ).hasMatch(viewModel.emailController.text.trim());
                            if (!emailValid) {
                              return 'Please enter valid email';
                            }
                            return null; //todo: valid
                          },
                        ),
                        SizedBox(height: height * 0.02),
                        CustomTextFormField(
                          prefixIcon: Image.asset(AppAssets.passwordIcon),
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                isObscure = !isObscure;
                              });
                            },
                            child: Image.asset(AppAssets.showPasswordIcon),
                          ),
                          hintText: AppLocalizations.of(context)!.password,
                          controller: viewModel.passwordController,
                          obscureText: isObscure,
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'Please enter password';
                            }
                            if (text.length < 6) {
                              return 'Password must be 6 characters';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: height * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "${AppLocalizations.of(context)!.forget_password}?",
                              style: AppStyles.bold16Primary.copyWith(
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.primaryLight,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: height * 0.03),
                        CustomElevatedButton(
                          onPressed: () {
                            viewModel.login(context);
                          },
                          text: AppLocalizations.of(context)!.login,
                        ),
                        SizedBox(height: height * 0.03),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.do_not_have_account,
                              style: AppStyles.medium16Black,
                            ),
                            TextButton(
                              onPressed: () {
                                //todo: navigate to register screen
                                Navigator.of(
                                  context,
                                ).pushNamed(AppRoutes.registerRouteName);
                              },
                              child: Text(
                                AppLocalizations.of(context)!.create_account,
                                style: AppStyles.bold16Primary.copyWith(
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppColors.primaryLight,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: height * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Container(
                            //   height: 1.5,
                            //   width: 160,
                            //   color: AppColors.primaryLight,
                            //   child: Spacer(),
                            // ),
                            Expanded(
                              child: Divider(
                                thickness: 1,
                                color: AppColors.primaryLight,
                                indent: width * 0.1,
                                endIndent: width * 0.04,
                              ),
                            ),
                            Text(
                              AppLocalizations.of(context)!.or,
                              style: AppStyles.medium16Primary,
                            ),
                            Expanded(
                              child: Divider(
                                thickness: 1,
                                color: AppColors.primaryLight,
                                indent: width * 0.04,
                                endIndent: width * 0.1,
                              ),
                            ),
                            // Container(
                            //   height: 1.5,
                            //   width: 160,
                            //   color: AppColors.primaryLight,
                            //   child: Spacer(),
                            // ),
                          ],
                        ),
                        SizedBox(height: height * 0.025),
                        CustomElevatedButton(
                          mainAxisAlignment: MainAxisAlignment.center,
                          onPressed: () {},
                          text: AppLocalizations.of(context)!.login_with_google,
                          backgroundColor: AppColors.transparentColor,
                          textStyle: AppStyles.medium20Primary,
                          icon: true,
                          iconWidget: Image.asset(AppAssets.googleIcon),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  @override
  void hideMyLoading() {
    // TODO: implement hideMyLoading
    DialogUtils.hideLoading(context: context);
  }

  @override
  void showMyLoading(String loadingText) {
    // TODO: implement showMyLoading
    DialogUtils.showLoading(context: context, loadingText: loadingText);
  }

  @override
  void showMyMessage(String message , {VoidCallback? onOk} ) {
    // TODO: implement showMyMessage
    DialogUtils.showMessage(context: context, message: message , posActionName: 'Ok' , posAction: onOk);
  }

  @override
  void navigatorFunc() {
    // TODO: implement navigatorFunc
      Navigator.pushReplacementNamed(context, AppRoutes.homeRouteName);
  }

  // void login() async {
  //   if (formKey.currentState?.validate() == true) {
  //     DialogUtils.showLoading(context: context, loadingText: 'Waiting...');
  //     try {
  //       final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
  //         email: emailController.text.trim(),
  //         password: passwordController.text,
  //       );
  //
  //       var user = await FirebaseUtils.readUsersFromFireStore(credential.user?.uid ?? '');
  //
  //       // 1. اقفل الـ Loading فوراً بعد انتهاء العملية سواء نجحت أو فشلت في جلب البيانات
  //       if (!mounted) return;
  //       DialogUtils.hideLoading(context: context);
  //
  //       if (user == null) {
  //         DialogUtils.showMessage(
  //           context: context,
  //           message: 'User data not found.',
  //           title: 'Error',
  //           posActionName: 'Ok',
  //         );
  //         return;
  //       }
  //
  //       // 2. تحديث الـ Provider
  //       var userProvider = Provider.of<UserProvider>(context, listen: false);
  //       userProvider.updateUser(user);
  //
  //       // 3. رسالة النجاح والـ Navigation
  //       DialogUtils.showMessage(
  //         context: context,
  //         message: 'Login Successfully.',
  //         title: 'Success.',
  //         posActionName: 'Ok',
  //         posAction: () {
  //           // استخدم pushReplacementNamed عشان ميرجعش للوجين تاني
  //           Navigator.of(context).pushReplacementNamed(AppRoutes.homeRouteName);
  //         },
  //       );
  //
  //     } on FirebaseAuthException catch (e) {
  //       if (!mounted) return;
  //       DialogUtils.hideLoading(context: context);
  //
  //       String errorMessage = 'Something went wrong';
  //       if (e.code == 'network-request-failed') {
  //         errorMessage = 'Network error occurred.';
  //       } else if (e.code == 'user-not-found' || e.code == 'wrong-password' || e.code == 'invalid-credential') {
  //         errorMessage = 'Invalid email or password.';
  //       }
  //
  //       DialogUtils.showMessage(
  //         context: context,
  //         message: errorMessage,
  //         title: 'Error',
  //         posActionName: 'Ok',
  //       );
  //     } catch (e) {
  //       if (!mounted) return;
  //       DialogUtils.hideLoading(context: context);
  //       DialogUtils.showMessage(
  //         context: context,
  //         message: e.toString(),
  //         title: 'Error',
  //         posActionName: 'Ok',
  //       );
  //     }
  //   }
  // }
}

