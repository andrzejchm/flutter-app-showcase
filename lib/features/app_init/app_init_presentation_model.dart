import 'package:dartz/dartz.dart';
import 'package:flutter_demo/core/domain/model/app_init_failure.dart';
import 'package:flutter_demo/core/domain/model/user.dart';
import 'package:flutter_demo/core/utils/bloc_extensions.dart';
import 'package:flutter_demo/features/app_init/app_init_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class AppInitPresentationModel implements AppInitViewModel {
  /// Creates the initial state
  AppInitPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    AppInitInitialParams initialParams,
  )   : appInitResult = const FutureResult.empty(),
        user = const User.anonymous();

  /// Used for the copyWith method
  AppInitPresentationModel._({
    required this.appInitResult,
    required this.user,
  });

  final FutureResult<Either<AppInitFailure, Unit>> appInitResult;
  final User user;

  @override
  bool get isLoading => appInitResult.isPending();

  AppInitPresentationModel copyWith({
    FutureResult<Either<AppInitFailure, Unit>>? appInitResult,
    User? user,
  }) =>
      AppInitPresentationModel._(
        appInitResult: appInitResult ?? this.appInitResult,
        user: user ?? this.user,
      );
}

/// Interface to expose fields used by the view (page).
abstract class AppInitViewModel {
  bool get isLoading;
}
