import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/ui/auth/register/register_navigator.dart';
import 'package:evently_app/ui/auth/register/register_screen_view_model.dart';
import 'package:evently_app/ui/home/taps/widgets/custom_elevated_button.dart';
import 'package:evently_app/ui/home/taps/widgets/custom_text_form_field.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_routes.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:evently_app/utils/dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utils/app_assets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> implements RegisterNavigator{
  TextEditingController nameController = TextEditingController(text: 'Dounya');

  TextEditingController emailController = TextEditingController(
    text: 'dounya@gmail.com',
  );

  TextEditingController passwordController = TextEditingController(
    text: '123456',
  );

  TextEditingController rePasswordController = TextEditingController(
    text: '123456',
  );

  var formKey = GlobalKey<FormState>();
  bool isObscurePassword = true;
  bool isObscureRePassword = true;

  RegisterScreenViewModel viewModel = RegisterScreenViewModel();

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
        appBar: AppBar(
          backgroundColor: AppColors.whiteBgColor,
          title: Text(
            AppLocalizations.of(context)!.register,
            style: AppStyles.bold16Black,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.04,
            vertical: height * 0.03,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.asset(AppAssets.logo, height: height * 0.22),
                      SizedBox(height: height * 0.04),
                      CustomTextFormField(
                        prefixIcon: Image.asset(AppAssets.nameIcon),
                        hintText: AppLocalizations.of(context)!.name,
                        controller: nameController,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please enter name'; //todo: invalid
                          }
                          return null; //todo: valid
                        },
                      ),
                      SizedBox(height: height * 0.02),
                      CustomTextFormField(
                        prefixIcon: Image.asset(AppAssets.emailIcon),
                        hintText: AppLocalizations.of(context)!.email,
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please enter email'; //todo: invalid
                          }
                          final bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                          ).hasMatch(emailController.text.trim());
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
                              isObscurePassword = !isObscurePassword;
                            });
                          },
                          child: Image.asset(AppAssets.showPasswordIcon),
                        ),
                        hintText: AppLocalizations.of(context)!.password,
                        controller: passwordController,
                        keyboardType: TextInputType.number,
                        obscureText: isObscurePassword,
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
                      CustomTextFormField(
                        prefixIcon: Image.asset(AppAssets.passwordIcon),
                        suffixIcon: InkWell(
                          onTap: () {
                            isObscureRePassword = !isObscureRePassword;
                            setState(() {});
                          },
                          child: Image.asset(AppAssets.showPasswordIcon),
                        ),
                        hintText: AppLocalizations.of(context)!.re_password,
                        controller: rePasswordController,
                        obscureText: isObscureRePassword,
                        keyboardType: TextInputType.number,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please enter re-password';
                          }
                          if (text.length < 6) {
                            return 'Password must be 6 characters';
                          }
                          if (passwordController.text !=
                              rePasswordController.text) {
                            return "Re password doesn't match the password";
                          }
                          return null;
                        },
                      ),
      
                      SizedBox(height: height * 0.03),
                      CustomElevatedButton(
                        onPressed: () {
                          register();
                        },
                        text: AppLocalizations.of(context)!.create_account,
                      ),
                      SizedBox(height: height * 0.03),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.already_have_account,
                            style: AppStyles.medium16Black,
                          ),
                          SizedBox(width: width * 0.02),
                          TextButton(
                            onPressed: () {
                              //todo: navigate to login screen
                              Navigator.pushReplacementNamed(
                                context,
                                AppRoutes.loginRouteName,
                              );
                            },
                            child: Text(
                              AppLocalizations.of(context)!.login,
                              style: AppStyles.bold16Primary.copyWith(
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.primaryLight,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.02),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void register() async {
    if (formKey.currentState?.validate() == true) {
      viewModel.register(emailController.text, passwordController.text , context ,nameController.text);
      //todo: register
      //todo: talking with firebase take time so we make a dialog to alert the user
      //todo: show loading
      // DialogUtils.showLoading(context: context, loadingText: 'Loading...');
      // try {
      //   //todo: sign up firebase auth
      //   final credential = await FirebaseAuth.instance
      //       .createUserWithEmailAndPassword(
      //         email: emailController.text,
      //         password: passwordController.text,
      //       );
      //   //todo: save user to fireStore
      //   MyUser myUser = MyUser(               ///obj from myUser to use it in the method => FirebaseUtils.addUsersToFireStore(myUser);
      //   id: credential.user?.uid ?? '',
      //       name: nameController.text,
      //       email: emailController.text,
      //   );
      //   await FirebaseUtils.addUsersToFireStore(myUser);
      //   //todo: save user in provider
      //   var userProvider = Provider.of<UserProvider>(context , listen: false);
      //   userProvider.updateUser(myUser);
      //   //todo: change selected index
      //   var eventListProvider = Provider.of<EventListProvider>(context , listen: false);
      //   eventListProvider.changeSelectedIndex(0, userProvider.currentUser!.id);
      //
      //   //todo: hide loading
      //   DialogUtils.hideLoading(context: context);
      //   //todo: show message
      //   DialogUtils.showMessage(
      //     context: context,
      //     message: 'Register Successfully.',
      //     title: 'Success.',
      //     posActionName: 'Ok',
      //     posAction: () {
      //       // Navigator.of(context).pushReplacementNamed(AppRoutes.homeRouteName);
      //       Navigator.pushNamedAndRemoveUntil(
      //         context,
      //         AppRoutes.homeRouteName,
      //             (route) => false,
      //       );
      //     },
      //   );
      //   // print('Register Successfully.');
      //   // print('User ID: ${credential.user?.uid ?? ''}');
      // } on FirebaseAuthException catch (e) {
      //   if (e.code == 'weak-password') {
      //     //todo: hide loading
      //     DialogUtils.hideLoading(context: context);
      //     //todo: show message
      //     DialogUtils.showMessage(
      //       context: context,
      //       message: 'The password provided is too weak.',
      //       title: 'Error.',
      //       posActionName: 'Ok',
      //     );
      //     // print('The password provided is too weak.');
      //   } else if (e.code == 'email-already-in-use') {
      //     //todo: hide loading
      //     DialogUtils.hideLoading(context: context);
      //     //todo: show message
      //     DialogUtils.showMessage(
      //       context: context,
      //       message: 'The account already exists for that email.',
      //       title: 'Error.',
      //       posActionName: 'Ok',
      //     );
      //     // print('The account already exists for that email.');
      //   } else if (e.code == 'network-request-failed') {
      //     //todo: hide loading
      //     DialogUtils.hideLoading(context: context);
      //     //todo: show message
      //     DialogUtils.showMessage(
      //       context: context,
      //       message:
      //           'Network error (such as timeout, interrupted connection or unreachable host) has occurred.',
      //       title: 'Error.',
      //       posActionName: 'Ok',
      //     );
      //   }
      // } catch (e) {
      //   //todo: hide loading
      //   DialogUtils.hideLoading(context: context);
      //   //todo: show message
      //   DialogUtils.showMessage(
      //     context: context,
      //     message: e.toString(),
      //     title: 'Error.',
      //     posActionName: 'Ok',
      //   );
      //   // print(e);
      // }
    }
  }

  @override
  void hideMyLoading() {
    // TODO: implement hideMyLoading
    // Navigator.pop(context);
    DialogUtils.hideLoading(context: context);

  }

  @override
  void showMyLoading(String loadingText) {
    // TODO: implement showMyLoading
    DialogUtils.showLoading(context: context, loadingText: loadingText);
  }

  @override
  void showMyMessage(String message) {
    // TODO: implement showMyMessage
    DialogUtils.showMessage(context: context, message: message , posActionName: 'Ok' , posAction: () {
      Navigator.pushReplacementNamed(context, AppRoutes.homeRouteName);
    });
  }
}
