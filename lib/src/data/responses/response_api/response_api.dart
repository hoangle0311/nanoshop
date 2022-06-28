class ResponseApi<T> {
  final String message;
  final String code;
  final String error;
  final T data;

  ResponseApi({
    required this.message,
    required this.code,
    required this.error,
    required this.data,
  });
}
