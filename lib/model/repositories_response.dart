enum ResponseStatus { initial, loading, success, error }

class RepositoriesResponse<T> {
  final ResponseStatus status;
  final T? data;
  final String? errorMessage;

  const RepositoriesResponse._({required this.status, this.data, this.errorMessage});

  factory RepositoriesResponse.initial() => RepositoriesResponse._(status: ResponseStatus.initial);

  factory RepositoriesResponse.loading() => RepositoriesResponse._(status: ResponseStatus.loading);

  factory RepositoriesResponse.success(T data) => RepositoriesResponse._(status: ResponseStatus.success, data: data);

  factory RepositoriesResponse.error(String message) => RepositoriesResponse._(status: ResponseStatus.error, errorMessage: message);
}
