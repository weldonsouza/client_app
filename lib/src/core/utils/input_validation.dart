final RegExp _emailRegex = RegExp(r'[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$');

class InputValidation {
  static String? validateEmail(String? value) {
    value ??= '';
    if (value.isEmpty) {
      return 'Digite seu e-mail';
    } else if (!value.contains(_emailRegex)) {
      return 'Formato inválido de email';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    value ??= '';
    if (value.isEmpty) {
      return 'Senha obrigatória!';
    }
    if (value.length < 6) {
      return 'Digite no mínimo 6 caracteres';
    }
    return null;
  }

  static String? validateCPF(String? value) {
    value ??= '';
    if (value.isEmpty) {
      return 'Digite seu CPF';
    } else if (!CPF.isValid(value)) {
      return 'CPF é inválido';
    }
    return null;
  }

  static String? validateBirthdate(String? value) {
    value ??= '';
    if (value.isEmpty) {
      return 'Data de nascimento é obrigatória';
    } else {
      final List<String> values = value.split('/');
      final String day = values[0];
      final String month = values[1];
      final String year = values[2];
      final DateTime? date = DateTime.tryParse('$year-$month-$day');
      if (date == null) {
        return 'Digite uma data válida';
      } else if (!(date.day == num.parse(day) &&
          date.month == num.parse(month) &&
          date.year == num.parse(year))) {
        return 'Digite uma data válida';
      }
    }
    return null;
  }

  static String? validatePhone(String? value) {
    value ??= '';
    if (value.isEmpty) {
      return 'Digite seu telefone.';
    }

    value = value.replaceAll(RegExp(r'[^\w\s]+'), '').split(' ').join();
    if (value.length != 11) {
      return 'Telefone com tamanho inválido. Deve conter 11 caracteres';
    }

    return null;
  }
}

class CPF {
  // Formatar número de CPF
  static String? format(String cpf) {
    if (cpf.isEmpty) return null;

    // Obter somente os números do CPF
    var numeros = cpf.replaceAll(RegExp(r'[^0-9]'), '');

    // Testar se o CPF possui 11 dígitos
    if (numeros.length != 11) return cpf;

    // Retornar CPF formatado
    return '${numeros.substring(0, 3)}.${numeros.substring(3, 6)}.${numeros.substring(6, 9)}-${numeros.substring(9)}';
  }

  // Validar número de CPF
  static bool isValid(String cpf) {
    if (cpf.isEmpty) return false;

    // Obter somente os números do CPF
    var numeros = cpf.replaceAll(RegExp(r'[^0-9]'), '');

    // Testar se o CPF possui 11 dígitos
    if (numeros.length != 11) return false;

    // Testar se todos os dígitos do CPF são iguais
    if (RegExp(r'^(\d)\1*$').hasMatch(numeros)) return false;

    // Dividir dígitos
    var digits = numeros.split('').map((String d) => int.parse(d)).toList();

    // Calcular o primeiro dígito verificador
    var calc_dv1 = 0;
    for (var i in Iterable<int>.generate(9, (i) => 10 - i)) {
      calc_dv1 += digits[10 - i] * i;
    }
    calc_dv1 %= 11;
    var dv1 = calc_dv1 < 2 ? 0 : 11 - calc_dv1;

    // Testar o primeiro dígito verificado
    if (digits[9] != dv1) return false;

    // Calcular o segundo dígito verificador
    var calc_dv2 = 0;
    for (var i in Iterable<int>.generate(10, (i) => 11 - i)) {
      calc_dv2 += digits[11 - i] * i;
    }
    calc_dv2 %= 11;
    var dv2 = calc_dv2 < 2 ? 0 : 11 - calc_dv2;

    // Testar o segundo dígito verificador
    if (digits[10] != dv2) return false;

    return true;
  }
}
