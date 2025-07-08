class ResponseApi<T> {
  final String status;
  final T data;

  ResponseApi({
    required this.status, 
    required this.data
  });
}
