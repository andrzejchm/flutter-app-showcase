// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:flutter_demo/core/helpers.dart';
import 'package:flutter_demo/core/utils/mvp_extensions.dart';
import 'package:flutter_demo/features/auth/login/login_presentation_model.dart';
import 'package:flutter_demo/features/auth/login/login_presenter.dart';
import 'package:flutter_demo/localization/app_localizations_utils.dart';

class LoginPage extends StatefulWidget with HasPresenter<LoginPresenter> {
  LoginPage({
    super.key,
    required this.presenter,
  });

  @override
  final LoginPresenter presenter;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with PresenterStateMixin<LoginViewModel, LoginPresenter, LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(32.0),
          child: stateObserver(
            builder: (context, state) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    hintText: appLocalizations.usernameHint,
                  ),

                  onChanged: (text) {
                    setState(() {
                      state.isLoginEnabled = true;
                    });
                  }, //TODO
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: appLocalizations.passwordHint,
                  ),
                  onChanged: (text) {
                    setState(() {
                      state.isLoginEnabled = true;
                    });
                  }, //TODO
                ),
                const SizedBox(height: 16),
                stateObserver(
                  builder: (context, state) {
                    if (!state.isLoginEnabled && isEmptyInput()) {
                      return const CircularProgressIndicator();
                    }
                    return ElevatedButton(
                      onPressed: state.isLoginEnabled && isEmptyInput()
                          ? () {
                              presenter
                                  .login(
                                usernameController.text,
                                passwordController.text,
                              )
                                  .whenComplete(() {
                                usernameController.text = '';
                                passwordController.text = '';
                              });
                            }
                          : null,
                      //TODO
                      child: Text(appLocalizations.logInAction),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );

  bool isEmptyInput() {
    return usernameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty;
  }
}
