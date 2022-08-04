import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_demo/core/domain/model/user.dart';
import 'package:flutter_demo/core/domain/stores/user_store.dart';
import 'package:flutter_demo/core/domain/use_cases/app_init_use_case.dart';
import 'package:flutter_demo/core/helpers.dart';
import 'package:flutter_demo/core/utils/bloc_extensions.dart';
import 'package:flutter_demo/core/utils/either_extensions.dart';
import 'package:flutter_demo/core/utils/mvp_extensions.dart';
import 'package:flutter_demo/features/app_init/app_init_navigator.dart';
import 'package:flutter_demo/features/app_init/app_init_presentation_model.dart';

class AppInitPresenter extends Cubit<AppInitViewModel> with CubitToCubitCommunicationMixin<AppInitViewModel> {
  AppInitPresenter(
    AppInitPresentationModel super.model,
    this.navigator,
    this.appInitUseCase,
    this.userStore,
  ) {
    listenTo<User>(
      userStore,
      onChange: (user) => emit(_model.copyWith(user: user)),
    );
  }

  final AppInitNavigator navigator;
  final AppInitUseCase appInitUseCase;
  final UserStore userStore;

  AppInitPresentationModel get _model => state as AppInitPresentationModel;

  Future<void> onInit() async {
    await appInitUseCase
        .execute() //
        .observeStatusChanges((result) => emit(_model.copyWith(appInitResult: result)))
        .asyncFold(
          (fail) => navigator.showError(fail.displayableFailure()),
          (success) => doNothing(), //todo!
        );
  }
}
