@example(#{
  id: "1",
  title: "Learn TypeScript",
  description: "Study TypeScript for better type safety.",
  completed: false,
})
@example(#{
  id: "2",
  title: "Build a TypeScript project",
  description: "Create a project using TypeScript.",
  completed: true,
})
model Todo {
  id: string;
  title: string;
  description: string;
  completed: boolean;
}
