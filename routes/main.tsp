import "@typespec/http";

import "./common.tsp";
import "./error.tsp";
import "../models";

using Http;

@service(#{ title: "Sample Service" })
namespace Main {
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
    } | NotFoundErrorResponse;

    @post
    @useAuth(BearerAuth)
    op createPet(@body pet: Pet, ...CommonParameters): {
      @statusCode statusCode: 201;
      @body pet: Pet;
    } | ValidationErrorResponse | UnauthorizedErrorResponse;

    @put
    @useAuth(BearerAuth)
    op updatePet(@path petId: string, @body pet: Pet, ...CommonParameters): {
      @statusCode statusCode: 200;
      @body pet: Pet;
    } | NotFoundErrorResponse | UnauthorizedErrorResponse;
  }

  @route("/todos")
  namespace Todos {
    @get
    op listTodos(...CommonParameters): {
      @statusCode statusCode: 200;
      @body todos: Todo[];
    };

    @get
    op getTodo(@path todoId: Todo.id, ...CommonParameters): {
      @statusCode statusCode: 200;
      @body todo: Todo;
    } | NotFoundErrorResponse;

    @post
    @useAuth(BearerAuth)
    op createTodo(@body todo: Todo, ...CommonParameters): {
      @statusCode statusCode: 201;
      @body todo: Todo;
    } | ValidationErrorResponse | UnauthorizedErrorResponse;

    @put
    @useAuth(BearerAuth)
    op updateTodo(
      @path todoId: string,
      @body todo: Todo,
      ...CommonParameters,
    ): {
      @statusCode statusCode: 200;
      @body todo: Todo;
    } | NotFoundErrorResponse | UnauthorizedErrorResponse;
  }
}
