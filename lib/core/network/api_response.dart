// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/19
// Description: 
// -------------------------------------------------------------------
sealed class ApiResponse<T> {
  const ApiResponse();

  factory ApiResponse.success(T data) = ApiSuccess<T>;
  factory ApiResponse.failure(String message) = ApiFailure<T>;
}

class ApiSuccess<T> extends ApiResponse<T> {
  final T data;
  const ApiSuccess(this.data);
}

class ApiFailure<T> extends ApiResponse<T> {
  final String messageKey;
  const ApiFailure(this.messageKey);
}