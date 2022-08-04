import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//ignore:prefer-match-file-name
mixin PresenterStateMixin<M, P extends Cubit<M>, T extends HasPresenter<P>> on State<T> {
  P get presenter => widget.presenter;

  M get state => presenter.state;

  Widget stateObserver({
    required BlocWidgetBuilder<M> builder,
    BlocBuilderCondition<M>? buildWhen,
  }) {
    return BlocBuilder<P, M>(
      bloc: presenter,
      buildWhen: buildWhen,
      builder: builder,
    );
  }

  @override
  void dispose() {
    super.dispose();
    presenter.close();
  }
}

mixin HasPresenter<P> on StatefulWidget {
  P get presenter;
}

mixin CubitToCubitCommunicationMixin<T> on Cubit<T> {
  final _subscriptions = <StreamSubscription<dynamic>>[];

  void listenTo<C>(Cubit<C> cubit, {required void Function(C) onChange}) =>
      addSubscription(cubit.stream.listen(onChange));

  void addSubscription(StreamSubscription<dynamic> subscription) {
    _subscriptions.add(subscription);
  }

  @override
  Future<void> close() async {
    await Future.wait(_subscriptions.map((it) => it.cancel()));
    await super.close();
    _subscriptions.clear();
  }
}
