import 'package:flutter_demo/core/domain/model/displayable_failure.dart';

class AppInitFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const AppInitFailure.unknown([this.cause]) : type = AppInitFailureType.Unknown;

  final AppInitFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case AppInitFailureType.Unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'AppInitFailure{type: $type, cause: $cause}';
}

enum AppInitFailureType {
  Unknown,
}
