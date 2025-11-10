import 'package:fpdart/fpdart.dart';

abstract class UsecaseSync<T, Params> {
  Either<Error, T> call(Params params);
}
