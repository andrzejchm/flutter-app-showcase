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
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  hintText: appLocalizations.usernameHint,
                ),
                onChanged: (text) => presenter.onUsernameChanged(usernameController.text),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: appLocalizations.passwordHint,
                ),
                onChanged: (text) => presenter.onPasswordChanged(passwordController.text),
              ),
              const SizedBox(height: 16),
              stateObserver(
                builder: (context, state) => Container(
                  child: state.isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: state.isLoginEnabled
                              ? () => presenter.onLoginButtonClicked(
                                    username: usernameController.text,
                                    password: passwordController.text,
                                  )
                              : null,
                          child: Text(appLocalizations.logInAction),
                        ),
                ),
              ),
            ],
          ),
        ),
      );

  @override
  void dispose() {
    _cleanUpControllers();
    super.dispose();
  }

  void _cleanUpControllers() {
    usernameController.dispose();
    passwordController.dispose();
  }
}
