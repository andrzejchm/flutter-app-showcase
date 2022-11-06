import 'package:equatable/equatable.dart';
import 'package:flutter_demo/localization/app_localizations_utils.dart';

/// A success with the title and message that could be easily displayed as a dialog or snackbar
class DisplayableSuccess extends Equatable {
  const DisplayableSuccess({
    required this.title,
    required this.message,
  });

  factory DisplayableSuccess.empty() => const DisplayableSuccess(
        title: '',
        message: '',
      );

  DisplayableSuccess.commonSuccess([String? message])
      : title = appLocalizations.commonSuccessTitle,
        message = message ?? appLocalizations.commonSuccessMessage;

  final String title;
  final String message;

  @override
  List<Object?> get props => [
        title,
        message,
      ];

  DisplayableSuccess copyWith({
    String? title,
    String? message,
  }) =>
      DisplayableSuccess(
        title: title ?? this.title,
        message: message ?? this.message,
      );
}

// ignore: too_many_public_members
abstract class HasDisplayableSuccess {
  DisplayableSuccess displayableSuccess();
}
