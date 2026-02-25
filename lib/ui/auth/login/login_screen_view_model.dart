import 'package:evently_app/ui/auth/login/login_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../firebase_utils.dart';
import '../../../providers/event_list_provider.dart';
import '../../../providers/user_provider.dart';

class LoginScreenViewModel extends ChangeNotifier {
  //todo: hold data - handel logic
  //todo: data
  var emailController = TextEditingController(text: 'dounya@gmail.com');
  var passwordController = TextEditingController(text: '123456');
  var formKey = GlobalKey<FormState>();
  late LoginNavigator navigator;

  //todo: logic
  void login(BuildContext context) async {
    if(formKey.currentState?.validate() == true){
    //todo: login
    //todo: show loading
    navigator.showMyLoading('Waiting...');
    // DialogUtils.showLoading(context: context, loadingText: 'Waiting...' );
    try {
      //todo: sign in firebase auth
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      //todo: read user from fireStore
      var user = await FirebaseUtils.readUsersFromFireStore(credential.user?.uid?? '');
      if(user == null) {
        return ;
      }
      //todo: save user in provider
      var userProvider = Provider.of<UserProvider>(context , listen: false);
      userProvider.updateUser(user);
      //todo: change selected index
      var eventListProvider = Provider.of<EventListProvider>(context , listen: false);
      eventListProvider.changeSelectedIndex(0, userProvider.currentUser!.id);
      eventListProvider.getAllFavouriteEventsFromFireStore(userProvider.currentUser!.id);
      //todo: hide loading
      navigator.hideMyLoading();
      // DialogUtils.hideLoading(context: context);
      //todo: show message
      navigator.showMyMessage('Login Successfully.' , onOk: () {
        //todo: navigate to home screen
        navigator.navigatorFunc();
      },);
      // DialogUtils.showMessage(
      //   context: context,
      //   message: 'Login Successfully.',
      //   title: 'Success.',
      //   posActionName: 'Ok',
      //   posAction: () {
      //     Navigator.of(context).pushReplacementNamed(AppRoutes.homeRouteName);
      //   },
      // );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'network-request-failed') {
        //todo: hide loading
        navigator.hideMyLoading();
        // DialogUtils.hideLoading(context: context);
        //todo: show message
        navigator.showMyMessage(
          'Network error (such as timeout, interrupted connection or unreachable host) has occurred.',
        );
        // DialogUtils.showMessage(
        //   context: context,
        //   message:
        //   'Network error (such as timeout, interrupted connection or unreachable host) has occurred.',
        //   title: 'Error.',
        //   posActionName: 'Ok',
        // );
      } else if (e.code == 'invalid-credential') {
        //todo: hide loading
        navigator.hideMyLoading();
        // DialogUtils.hideLoading(context: context);
        //todo: show message
        navigator.showMyMessage(
          'The supplied auth credential is incorrect, malformed or has expired.',
        );
        // DialogUtils.showMessage(
        //   context: context,
        //   message:
        //   'The supplied auth credential is incorrect, malformed or has expired.',
        //   title: 'Error.',
        //   posActionName: 'Ok',
        // );
      }
    } catch (e) {
      //todo: hide loading
      navigator.hideMyLoading();
      // DialogUtils.hideLoading(context: context);
      //todo: show message
      navigator.showMyMessage(e.toString());
      // DialogUtils.showMessage(
      //   context: context,
      //   message: e.toString(),
      //   title: 'Error.',
      //   posActionName: 'Ok',
      // );
    }
  }
  }
}
