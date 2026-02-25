import 'package:evently_app/ui/auth/register/register_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../firebase_utils.dart';
import '../../../model/my_user.dart';
import '../../../providers/event_list_provider.dart';
import '../../../providers/user_provider.dart';


class RegisterScreenViewModel extends ChangeNotifier {
  //todo: hold data - handle logic
  late RegisterNavigator navigator ;

  void register(String email , String password , BuildContext context , String name) async {
    //todo: register
    //todo: show loading
    navigator.showMyLoading('Loading...');
    // DialogUtils.showLoading(context: context, loadingText: 'Loading...');
    try {
      //todo: sign up firebase auth
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      //todo: save user to fireStore
      MyUser myUser = MyUser(               ///obj from myUser to use it in the method => FirebaseUtils.addUsersToFireStore(myUser);
        id: credential.user?.uid ?? '',
        name: name,
        email: email,
      );
      await FirebaseUtils.addUsersToFireStore(myUser);
      //todo: save user in provider
      var userProvider = Provider.of<UserProvider>(context , listen: false);
      userProvider.updateUser(myUser);
      //todo: change selected index
      var eventListProvider = Provider.of<EventListProvider>(context , listen: false);
      eventListProvider.changeSelectedIndex(0, userProvider.currentUser?.id ?? '');

      //todo: hide loading
      navigator.hideMyLoading();
      // DialogUtils.hideLoading(context: context);
      //todo: show message
      navigator.showMyMessage('Register Successfully.');
      // DialogUtils.showMessage(
      //   context: context,
      //   message: 'Register Successfully.',
      //   title: 'Success.',
      //   posActionName: 'Ok',
      //   posAction: () {
      //     // Navigator.of(context).pushReplacementNamed(AppRoutes.homeRouteName);
      //     Navigator.pushNamedAndRemoveUntil(
      //       context,
      //       AppRoutes.homeRouteName,
      //           (route) => false,
      //     );
      //   },
      // );
      // print('Register Successfully.');
      // print('User ID: ${credential.user?.uid ?? ''}');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        //todo: hide loading
        navigator.hideMyLoading();
        // DialogUtils.hideLoading(context: context);
        //todo: show message
        navigator.showMyMessage('The password provided is too weak.');
        // DialogUtils.showMessage(
        //   context: context,
        //   message: 'The password provided is too weak.',
        //   title: 'Error.',
        //   posActionName: 'Ok',
        // );
        // print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        //todo: hide loading
        navigator.hideMyLoading();
        // DialogUtils.hideLoading(context: context);
        //todo: show message
        navigator.showMyMessage('The account already exists for that email.');
        // DialogUtils.showMessage(
        //   context: context,
        //   message: 'The account already exists for that email.',
        //   title: 'Error.',
        //   posActionName: 'Ok',
        // );
        // print('The account already exists for that email.');
      } else if (e.code == 'network-request-failed') {
        //todo: hide loading
        navigator.hideMyLoading();
        // DialogUtils.hideLoading(context: context);
        //todo: show message
        navigator.showMyMessage('Network error (such as timeout, interrupted connection or unreachable host) has occurred.');
        // DialogUtils.showMessage(
        //   context: context,
        //   message:
        //   'Network error (such as timeout, interrupted connection or unreachable host) has occurred.',
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
      // print(e);
    }
  }
}
