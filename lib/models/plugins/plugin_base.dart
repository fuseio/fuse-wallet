abstract class Plugin {
  final String name;
  final bool isActive;

  Plugin({
    this.name,
    this.isActive,
  });

  dynamic toJson() => {'name': name, 'isActive': isActive};
}
