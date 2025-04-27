import "@typespec/http";

using Http;

@error
model NotFoundError {
  code: "NOT_FOUND";
  message: string;
}

@error
model ValidationError {
  code: "VALIDATION_ERROR";
  message: string;
  details: string[];
}

@error
model UnauthorizedError {
  code: "UNAUTHORIZED";
  message: string;
}

model NotFoundErrorResponse {
  @statusCode statusCode: 404;
  @body error: NotFoundError;
}

model ValidationErrorResponse {
  @statusCode statusCode: 400;
  @body error: ValidationError;
}

model UnauthorizedErrorResponse {
  @statusCode statusCode: 401;
  @body error: UnauthorizedError;
}
