import "@typespec/http";
import "./error.tsp";

using Http;

model CommonParameters {
  @header
  requestID: string;

  @query
  locale?: string;

  @header
  clientVersion?: string;
}

@doc("List of {name}", T)
op List<T extends {}>(...CommonParameters): {
  @statusCode statusCode: 200;
  @body items: T[];
};

@doc("Detail of {name}", T)
op Detail<T extends {}>(@path id: string, ...CommonParameters): {
  @statusCode statusCode: 200;
  @body item: T;
} | NotFoundErrorResponse;

@doc("Create {name}", T)
op CreateItem<T extends {}>(@body item: T, ...CommonParameters): {
  @statusCode statusCode: 201;
  @body item: T;
} | ValidationErrorResponse | UnauthorizedErrorResponse;

@doc("Update {name}", T)
op UpdateItem<T extends {}>(@path id: string, @body item: T, ...CommonParameters): {
  @statusCode statusCode: 200;
  @body item: T;
} | NotFoundErrorResponse | UnauthorizedErrorResponse;
