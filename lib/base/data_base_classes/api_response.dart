import 'failures.dart';
import 'dart:core';

class ApiResponse<T> {
  final T data;
  final Failure error;
  final bool hasError;

  ApiResponse({
    this.data,
    this.error,
  })  : hasError = error != null,
        assert((data != null) || (error != null),
            'Must have one of data or error');
}

extension Converter<E> on ApiResponse<Map<String, dynamic>> {
  ApiResponse<E> transform<E>(
    E Function(Map<String, dynamic> data) transformer, {
    bool ignoreError = false,
  }) {
    E transformedData;
    if (data != null)
      transformedData = (ignoreError || !hasError) ? transformer(data) : null;
    return ApiResponse<E>(
      data: transformedData,
      error: error,
    );
  }

  ApiResponse<bool> transformToStatusOnly() {
    var status = false;
    if (data != null) status = data['status'] == 'success';

    return ApiResponse(
      data: status ?? false,
      error: error,
    );
    // return transform((data) {
    //   final status = data['success'] as bool;
    //   return status ?? false;
    // });
  }
}

