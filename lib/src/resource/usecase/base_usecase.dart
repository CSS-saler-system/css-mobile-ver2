import 'package:either_dart/either.dart';

import '../data/failure.dart';

abstract class BaseUseCase<In, Out> {
  // Future<Either<Failure, Out>> execute(In input);
  Future<Out> execute(In input);
}
