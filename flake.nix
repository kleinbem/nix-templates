{
  description = "Project Templates";

  outputs = { ... }: {
    templates = {
      default = {
        path = ./default;
        description = "Default template";
      };
    };
  };
}
