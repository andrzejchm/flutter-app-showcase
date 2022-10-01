// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/core/dimens.dart';
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
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(Dimens.VALUE_32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: appLocalizations.usernameHint,
                ),
                onChanged: (text) => presenter.updateUserName(text),
              ),
              const SizedBox(height: Dimens.VALUE_8),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: appLocalizations.passwordHint,
                ),
                onChanged: (text) => presenter.updatePassword(text),
              ),
              const SizedBox(height: Dimens.VALUE_16),
              stateObserver(
                builder: (context, state) => Column(
                  children: [
                    if (state.isLoading)
                      const CircularProgressIndicator()
                    else
                      ElevatedButton(
                        onPressed: state.isLoginEnabled ? () => presenter.login() : null,
                        child: Text(appLocalizations.logInAction),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
