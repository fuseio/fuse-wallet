// String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
extension MyString on String {
  String capitalize() {
    return this[0].toUpperCase() + this.substring(1);
  }
}
