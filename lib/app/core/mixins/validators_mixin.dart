import '../helpers/app_helpers.dart';

mixin ValidatorsMixin {
  String? isNotEmpty(String? value, [String? message]) {
    if (value?.trim().isEmpty ?? true) {
      return message ?? 'O campo é obrigatório';
    }
    return null;
  }

  String? isNotZero(String? value, [String? message]) {
    if (int.tryParse(value ?? '0') == 0) {
      return message ?? 'O valor não pode ser 0';
    }
    return null;
  }

  String? isEqual(String? value, String? comparableValue, [String? message]) {
    if (value != comparableValue) return message ?? 'O campo deve ser igual';
    return null;
  }

  String? isValidEmail(String? value, [String? message]) {
    if (!AppHelpers.isValidEmail(value)) {
      return message ?? 'Por favor digite um email válido';
    }
    return null;
  }

  String? isValidPassword(String? value, [String? message]) {
    if ((value?.length ?? 0) < 6) {
      return message ?? 'A senha deve ter ao menos 6 caracteres';
    }
    return null;
  }

  String? matchWithOther(String? value, String? otherValue, [String? message]) {
    if (value != otherValue) {
      return message ?? 'O campo não confere';
    }
    return null;
  }

  String? isFilled(String? value, int size, [String? message]) {
    if ((value?.length ?? 0) < size) {
      return message ?? 'O campo deve ser totalmente preenchido';
    }
    return null;
  }

  String? isMoreThanZero(String? value, [String? message]) {
    final parsed = int.tryParse(value ?? '') ?? 0;
    if (parsed <= 0) {
      return message ?? 'O valor não pode ser 0';
    }
    return null;
  }

  String? isMoreThanZeroMoney(String? value, [String? message]) {
    if ((value ?? '') == 'R\$ 0,00') {
      return message ?? 'O valor não pode ser 0';
    }
    return null;
  }

  String? isLessThanOrEqualTo(String? value, double maxValue,
      [String? message]) {
    if (AppHelpers.revertCurrency(value ?? '') > maxValue) {
      return message ??
          'O valor não pode ser maior que ${AppHelpers.formatCurrency(maxValue)}';
    }
    return null;
  }

  String? combine(List<String? Function()> validators) {
    for (var validator in validators) {
      final result = validator();
      if (result != null) return result;
    }
    return null;
  }
}
