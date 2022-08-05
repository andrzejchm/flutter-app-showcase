// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/core/utils/mvp_extensions.dart';
import 'package:flutter_demo/features/auth/login/login_presentation_model.dart';
import 'package:flutter_demo/features/auth/login/login_presenter.dart';
import 'package:flutter_demo/localization/app_localizations_utils.dart';
import 'package:flutter_demo/utils/dimensions.dart';

class LoginPage extends StatefulWidget with HasPresenter<LoginPresenter> {
  const LoginPage({
    required this.presenter,
    super.key,
  });

  @override
  final LoginPresenter presenter;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with PresenterStateMixin<LoginViewModel, LoginPresenter, LoginPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: stateObserver(
          builder: (context, state) => Padding(
            padding: const EdgeInsets.all(
              Dimensions.PADDING_32,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: appLocalizations.usernameHint,
                  ),
                  onChanged: (username) => presenter.usernameChanged(username),
                ),
                const SizedBox(
                  height: Dimensions.ITEM_HEIGHT_8,
                ),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: appLocalizations.passwordHint,
                  ),
                  onChanged: (password) => presenter.passwordChanged(password),
                ),
                const SizedBox(
                  height: Dimensions.ITEM_HEIGHT_16,
                ),
                stateObserver(
                  builder: (context, state) => state.ifValid
                      ? ElevatedButton(
                          onPressed: () => presenter.login(),
                          child: Text(appLocalizations.logInAction),
                        )
                      : const SizedBox.shrink(),
                ),
                if (state.isLoading) const CircularProgressIndicator(),
              ],
            ),
          ),
        ),
      );
}
