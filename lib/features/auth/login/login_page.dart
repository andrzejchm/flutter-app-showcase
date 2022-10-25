// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/core/utils/mvp_extensions.dart';
import 'package:flutter_demo/features/auth/login/login_presentation_model.dart';
import 'package:flutter_demo/features/auth/login/login_presenter.dart';
import 'package:flutter_demo/localization/app_localizations_utils.dart';

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

class _LoginPageState extends State<LoginPage> with PresenterStateMixin<LoginViewModel, LoginPresenter, LoginPage> {
  late TextEditingController usernameTextController;
  late TextEditingController passwordTextController;

  @override
  void initState() {
    usernameTextController = TextEditingController();
    passwordTextController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    usernameTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: usernameTextController,
                decoration: InputDecoration(
                  hintText: appLocalizations.usernameHint,
                ),
                onChanged: (text) => onFieldsUpdated(),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: passwordTextController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: appLocalizations.passwordHint,
                ),
                onChanged: (text) => onFieldsUpdated(),
              ),
              const SizedBox(height: 16),
              stateObserver(
                builder: (context, state) => state.isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: state.isLoginEnabled ? null : Colors.grey,
                        ),
                        onPressed: () => onLoginPressed(),
                        child: Text(appLocalizations.logInAction),
                      ),
              ),
            ],
          ),
        ),
      );

  void onFieldsUpdated() {
    presenter.setFieldsStatus(
      usernameTextController.text,
      passwordTextController.text,
    );
  }

  void onLoginPressed() {
    if (state.isLoginEnabled) {
      presenter.onLogin(
        usernameTextController.text.trim(),
        passwordTextController.text.trim(),
      );
    }
  }
}
