class Response<T> {
  bool status;
  String? message;
  T data;

  Response({
    required this.status,
    this.message,
    required this.data,
  });

  factory Response.fromJson(
    Map<String, dynamic> json,
    T Function(List<Map<String, dynamic>>) create,
  ) {
    return Response<T>(
      status: json['status'],
      message: json['message'],
      data: create(json['data']),
    );
  }
}
