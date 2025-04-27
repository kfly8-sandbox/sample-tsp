import "@typespec/http";

using Http;
@service(#{ title: "Widget Service" })
namespace PetStore;

model CommonParameters {
  @header
  requestID: string;

  @query
  locale?: string;

  @header
  clientVersion?: string;
}

model Pet {
  id: string;

  @minLength(1)
  @maxLength(100)
  name: string;

  @minValue(0)
  @maxValue(100)
  age: int32;

  kind: "dog" | "cat";
}

model AnalyzeResult {
  id: string;
  analysis: string;
}

@route("/pets")
namespace Pets {
  @get
  op listPets(...CommonParameters): {
    @statusCode statusCode: 200;
    @body pets: Pet[];
  };

  @get
  op getPet(@path petId: Pet.id, ...CommonParameters): {
    @statusCode statusCode: 200;
    @body pet: Pet;
  } | {
    @statusCode statusCode: 404;
    @body error: NotFoundError;
  };

  @post
  @useAuth(BearerAuth)
  op createPet(@body pet: Pet, ...CommonParameters): {
    @statusCode statusCode: 201;
    @body pet: Pet;
  } | {
    @statusCode statusCode: 400;
    @body error: ValidationError;
  } | {
    @statusCode statusCode: 401;
    @body error: UnauthorizedError;
  };

  @put
  @useAuth(BearerAuth)
  op updatePet(@path petId: string, @body pet: Pet, ...CommonParameters): {
    @statusCode statusCode: 200;
    @body pet: Pet;
  } | {
    @statusCode statusCode: 404;
    @body error: NotFoundError;
  } | {
    @statusCode statusCode: 401;
    @body error: UnauthorizedError;
  };
}

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
