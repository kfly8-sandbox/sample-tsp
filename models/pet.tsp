
scalar PetID extends string;

@example(#{ id: "123", name: "Fluffy", age: 5, kind: "dog" })
model Pet {
  id: PetID;

  @minLength(1)
  @maxLength(100)
  name: string;

  @minValue(0)
  @maxValue(100)
  age: int32;

  kind: "dog" | "cat";
}
