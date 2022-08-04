import 'package:dartz/dartz.dart';
import 'package:flutter_demo/core/helpers.dart';
import 'package:flutter_demo/core/utils/logging.dart';

Either<L, R> success<L, R>(R r) => right(r);

Either<L, R> failure<L, R>(L l) => left(l);

extension EitherExtensions<L, R> on Either<L, R> {
  bool get isFailure => isLeft();

  bool get isSuccess => isRight();

  R? getSuccess() => fold((l) => null, (r) => r);

  L? getFailure() => fold((l) => l, (r) => null);
}

extension FutureEither<L, R> on Future<Either<L, R>> {
  Future<Either<L, R2>> flatMap<R2>(Function1<R, Future<Either<L, R2>>> f) {
    return then(
      (either1) => either1.fold(
        (l) => Future.value(left<L, R2>(l)),
        f,
      ),
    );
  }

  Future<Either<L2, R>> leftMap<L2>(Function1<L, Either<L2, R>> f) {
    return then(
      (either1) => either1.fold(
        (l) => Future.value(f(l)),
        (r) => Future.value(right<L2, R>(r)),
      ),
    );
  }

  Future<Either<L, R2>> map<R2>(Function1<R, Either<L, R2>> f) {
    return then(
      (either1) => either1.fold(
        (l) => Future.value(left<L, R2>(l)),
        (r) => Future.value(f(r)),
      ),
    );
  }

  Future<Either<L2, R>> mapFailure<L2>(L2 Function(L fail) errorMapper) async {
    return (await this).leftMap(errorMapper);
  }

  Future<Either<L, R2>> mapSuccess<R2>(R2 Function(R response) responseMapper) async {
    return (await this).map(responseMapper);
  }

  Future<Either<L, R>> doOn({
    void Function(L fail)? fail,
    void Function(R success)? success,
  }) async {
    try {
      (await this).fold(
        fail ?? (_) => doNothing(),
        success ?? (_) => doNothing(),
      );
      return this;
    } catch (e, stack) {
      logError(e, stack);
      rethrow;
    }
  }

  Future<R2> asyncFold<R2>(
    R2 Function(L fail) fail,
    R2 Function(R success) success,
  ) async =>
      (await this).fold(fail, success);

  Future<R> getOrThrow() async => asyncFold(
        (l) => throw l as Object,
        (r) => r,
      );
}
