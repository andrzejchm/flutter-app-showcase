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
  static const _loadingProgressSize = Size(16.0, 16.0);
  final _usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _usernameController.text = presenter.state.username;
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: appLocalizations.usernameHint,
              ),
              controller: _usernameController,
              onChanged: presenter.usernameChanged,
            ),
            const SizedBox(height: 8),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: appLocalizations.passwordHint,
              ),
              onChanged: presenter.passwordChanged,
            ),
            const SizedBox(height: 16),
            stateObserver(
              builder: (context, state) => ElevatedButton(
                onPressed: state.isLoginEnabled ? presenter.logInClicked : null,
                child: state.isLoggingIn
                    ? SizedBox(
                        width: _loadingProgressSize.width,
                        height: _loadingProgressSize.height,
                        child: CircularProgressIndicator(
                          backgroundColor: theme.backgroundColor,
                        ),
                      )
                    : Text(appLocalizations.logInAction),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
