import "@typespec/http";

import "./common.tsp";
import "./error.tsp";
import "../models";

using Http;

@service(#{ title: "Sample Service" })
namespace Main {
  @route("/pets")
  namespace Pets {
    @get op listPets is List<Pet>;
    @get op getPet is Detail<Pet>;
    @post op createPet is CreateItem<Pet>;
    @put op updatePet is UpdateItem<Pet>;

    // Authentication configuration
    @@useAuth(createPet, BearerAuth);
    @@useAuth(updatePet, BearerAuth);
  }

  @route("/todos")
  namespace Todos {
    @get op listTodos is List<Todo>;
    @get op getTodo is Detail<Todo>;
    @post op createPet is CreateItem<Todo>;
    @put op updatePet is UpdateItem<Todo>;

    @@useAuth(createPet, BearerAuth);
    @@useAuth(updatePet, BearerAuth);
  }
}
