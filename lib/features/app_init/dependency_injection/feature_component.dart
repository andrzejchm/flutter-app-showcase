import 'package:flutter_demo/core/domain/use_cases/app_init_use_case.dart';
import 'package:flutter_demo/dependency_injection/app_component.dart';
import 'package:flutter_demo/features/app_init/app_init_initial_params.dart';
import 'package:flutter_demo/features/app_init/app_init_navigator.dart';
import 'package:flutter_demo/features/app_init/app_init_page.dart';
import 'package:flutter_demo/features/app_init/app_init_presentation_model.dart';
import 'package:flutter_demo/features/app_init/app_init_presenter.dart';
//DO-NOT-REMOVE APP_COMPONENT_IMPORTS

/// registers all the dependencies in dependency graph in get_it package
void configureDependencies() {
  _configureGeneralDependencies();
  _configureRepositories();
  _configureStores();
  _configureUseCases();
  _configureMvp();
}

//ignore: long-method
void _configureGeneralDependencies() {
  // ignore: unnecessary_statements
  getIt
      //DO-NOT-REMOVE GENERAL_DEPS_GET_IT_CONFIG
      ;
}

//ignore: long-method
void _configureRepositories() {
  // ignore: unnecessary_statements
  getIt
      //DO-NOT-REMOVE REPOSITORIES_GET_IT_CONFIG
      ;
}

//ignore: long-method
void _configureStores() {
  // ignore: unnecessary_statements
  getIt
      //DO-NOT-REMOVE STORES_GET_IT_CONFIG
      ;
}

//ignore: long-method
void _configureUseCases() {
  // ignore: unnecessary_statements
  getIt
        ..registerFactory<AppInitUseCase>(
          () => const AppInitUseCase(),
        )
      //DO-NOT-REMOVE USE_CASES_GET_IT_CONFIG
      ;
}

//ignore: long-method
void _configureMvp() {
  // ignore: unnecessary_statements
  getIt
        ..registerFactory<AppInitNavigator>(
          () => AppInitNavigator(getIt()),
        )
        ..registerFactoryParam<AppInitPresentationModel, AppInitInitialParams, dynamic>(
          (params, _) => AppInitPresentationModel.initial(params),
        )
        ..registerFactoryParam<AppInitPresenter, AppInitInitialParams, dynamic>(
          (initialParams, _) => AppInitPresenter(
            getIt(param1: initialParams),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<AppInitPage, AppInitInitialParams, dynamic>(
          (initialParams, _) => AppInitPage(
            presenter: getIt(param1: initialParams),
          ),
        )
      //DO-NOT-REMOVE MVP_GET_IT_CONFIG
      ;
}
