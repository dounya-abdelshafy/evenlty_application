import 'dart:ui';

abstract class LoginNavigator {
  //todo: contains actions between view(UI) , viewModel(Logic) => expressing by abstract methods
  void showMyLoading(String loadingText);
  void hideMyLoading();
  void showMyMessage(String message , {VoidCallback? onOk});
  void navigatorFunc();
}