abstract class Plugin {
  String name;
  bool isActive;

  Plugin({
    this.name,
    this.isActive,
  });

  dynamic toJson() => {'name': name, 'isActive': isActive};
}
