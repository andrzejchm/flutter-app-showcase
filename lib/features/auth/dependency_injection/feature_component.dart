import 'package:flutter_demo/dependency_injection/app_component.dart';
import 'package:flutter_demo/features/auth/domain/use_cases/log_in_use_case.dart';
import 'package:flutter_demo/features/auth/login/login_initial_params.dart';
import 'package:flutter_demo/features/auth/login/login_navigator.dart';
import 'package:flutter_demo/features/auth/login/login_page.dart';
import 'package:flutter_demo/features/auth/login/login_presentation_model.dart';
import 'package:flutter_demo/features/auth/login/login_presenter.dart';
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
        ..registerFactory<LogInUseCase>(
          () => LogInUseCase(
            getIt(),
          ),
        )
      //DO-NOT-REMOVE USE_CASES_GET_IT_CONFIG

      ;
}

//ignore: long-method
void _configureMvp() {
  // ignore: unnecessary_statements
  getIt
        ..registerFactory<LoginNavigator>(
          () => LoginNavigator(getIt()),
        )
        ..registerFactoryParam<LoginPresentationModel, LoginInitialParams, dynamic>(
          (params, _) => LoginPresentationModel.initial(params),
        )
        ..registerFactoryParam<LoginPresenter, LoginInitialParams, dynamic>(
          (initialParams, _) => LoginPresenter(
            getIt(param1: initialParams),
            getIt(),
          ),
        )
        ..registerFactoryParam<LoginPage, LoginInitialParams, dynamic>(
          (initialParams, _) => LoginPage(
            presenter: getIt(param1: initialParams),
          ),
        )
      //DO-NOT-REMOVE MVP_GET_IT_CONFIG

      ;
}
