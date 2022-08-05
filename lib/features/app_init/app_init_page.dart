// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/core/utils/mvp_extensions.dart';
import 'package:flutter_demo/features/app_init/app_init_presentation_model.dart';
import 'package:flutter_demo/features/app_init/app_init_presenter.dart';
import 'package:flutter_demo/resources/assets.gen.dart';

class AppInitPage extends StatefulWidget with HasPresenter<AppInitPresenter> {
  const AppInitPage({
    required this.presenter,
    super.key,
  });

  @override
  final AppInitPresenter presenter;

  @override
  State<AppInitPage> createState() => _AppInitPageState();
}

class _AppInitPageState extends State<AppInitPage>
    with PresenterStateMixin<AppInitViewModel, AppInitPresenter, AppInitPage> {
  @override
  void initState() {
    super.initState();
    presenter.onInit();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: stateObserver(
          builder: (context, state) => Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Assets.images.logo.image(),
                const SizedBox(height: 16),
                if (state.isLoading) const CircularProgressIndicator(),
              ],
            ),
          ),
        ),
      );
}
