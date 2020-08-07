class Validator {

  static String validatePresence(String value) {
    if (value.isEmpty) {
      return "Не можеть быть пустым";
//      return FlutterI18n.translate(context, "auth.errorMessages.nameEmpty");
    }

    return null;
  }
}