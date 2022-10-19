// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/core/helpers.dart';
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

class _LoginPageState extends State<LoginPage>
    with PresenterStateMixin<LoginViewModel, LoginPresenter, LoginPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              stateObserver(
                builder: (context, state) {
                  return TextField(
                    enabled: !state.isLoading,
                    decoration: InputDecoration(
                      hintText: appLocalizations.usernameHint,
                    ),
                    onChanged: presenter.changeUsername,
                  );
                },
              ),
              const SizedBox(height: 8),
              stateObserver(
                builder: (context, state) => TextField(
                  enabled: !state.isLoading,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: appLocalizations.passwordHint,
                  ),
                  onChanged: presenter.changePassword,
                ),
              ),
              const SizedBox(height: 16),
              stateObserver(
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed:
                        state.isLoginEnabled && !state.isLoading ? presenter.performLogin : null,
                    child: state.isLoading
                        ? const SizedBox(
                            height: 25,
                            width: 25,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(appLocalizations.logInAction),
                  );
                },
              ),
            ],
          ),
        ),
      );
}
