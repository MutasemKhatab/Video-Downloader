import 'package:equatable/equatable.dart';

abstract class DataState<T> extends Equatable {
  final T? data;
  final String? message;
  const DataState(this.data, this.message);

  @override
  List<Object?> get props => [data, message];
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(data, null);
}

class DataFailure<T> extends DataState<T> {
  const DataFailure(String message) : super(null, message);
}
