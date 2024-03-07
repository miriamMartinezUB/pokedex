extension ListExtension on List {
  String getAllElements() {
    String result = "";
    forEach((element) {
      result = '${result.isNotEmpty ? '$result,' : ''} $element';
    });
    return result;
  }
}
