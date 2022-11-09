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

class _LoginPageState extends State<LoginPage>
    with PresenterStateMixin<LoginViewModel, LoginPresenter, LoginPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: appLocalizations.usernameHint,
                ),
                onChanged: (value) => presenter.onUsernameUpdate(value),
              ),
              const SizedBox(height: 8),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: appLocalizations.passwordHint,
                ),
                onChanged: (value) => presenter.onPasswordUpdate(value),
              ),
              const SizedBox(height: 16),
              stateObserver(
                // avoid unnecessary builds while changing name or password
                buildWhen: (previous, current) =>
                    (previous.isLoginEnabled != current.isLoginEnabled) ||
                    (previous.isLoading != current.isLoading),
                builder: (_, state) => !state.isLoading
                    ? _buildLoginButton()
                    : _buildLoadingIndicator(),
              ),
            ],
          ),
        ),
      );

  Widget _buildLoginButton() => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: state.isLoginEnabled ? () => presenter.onLogin() : null,
          child: Text(appLocalizations.logInAction),
        ),
      );

  Widget _buildLoadingIndicator() => const SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: null,
          child: SizedBox(
            height: 20.0,
            width: 20.0,
            child: CircularProgressIndicator(),
          ),
        ),
      );
}
