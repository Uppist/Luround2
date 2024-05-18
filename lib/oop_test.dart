//SEALED CLASSES IN DART



abstract class Result {
  const Result._(); // Private constructor

  factory Result.success(int value) = SuccessResult;
  factory Result.error(String message) = ErrorResult;
}

class SuccessResult extends Result {
  final int value;
  SuccessResult(this.value) : super._();
}

class ErrorResult extends Result {
  final String message;
  ErrorResult(this.message) : super._();
}

void main() {
  Result result1 = Result.success(42);
  Result result2 = Result.error('Something went wrong');

  print(result1 is SuccessResult); // Output: true
  print(result2 is ErrorResult);   // Output: true
}
