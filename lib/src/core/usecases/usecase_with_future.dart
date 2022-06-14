abstract class UseCaseWithFuture<T, P> {
  Future<T> call(P params);
}
