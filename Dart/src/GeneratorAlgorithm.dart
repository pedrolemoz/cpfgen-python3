import 'dart:math' show Random;

class GeneratorAlgorithm {
  String generateCPF() {
    final Random random = Random();
    List<int> buildCPF =
        List<int>.generate(9, (_) => random.nextInt(9), growable: true);

    for (int i = 0; i < 2; i++) {
      buildCPF.add(digit(buildCPF));
    }

    return buildString(buildCPF);
  }

  int digit(List<int> buildCPF) {
    int sum = 0;
    int index = buildCPF.length + 1;

    for (int i in buildCPF) {
      sum += i * index;
      index -= 1;
    }

    return verifySum(sum);
  }

  int verifySum(int sum) {
    return ((sum % 11) < 2) ? 0 : 11 - (sum % 11);
  }

  String buildString(List<int> buildCPF) {
    List<String> getNumbers = [];
    String formattedCPF = "";

    for (int i in buildCPF) {
      getNumbers.add(i.toString());
    }

    getNumbers.insert(3, ".");
    getNumbers.insert(7, ".");
    getNumbers.insert(11, "-");

    for (String i in getNumbers) {
      formattedCPF += i;
    }

    return formattedCPF;
  }

  bool validateCPF(String insertedCPF) {
    if (insertedCPF.length < 11) {
      return false;
    }

    insertedCPF = insertedCPF.replaceAll('.', '');
    insertedCPF = insertedCPF.replaceAll('-', '');

    List<int> cpf =
        List<int>.generate(11, (int index) => int.parse(insertedCPF[index]));

    return digit(cpf.sublist(0, 9)) == cpf[9] &&
            digit(cpf.sublist(0, 10)) == cpf[10]
        ? true
        : false;
  }
}

void main() {
  GeneratorAlgorithm generator = GeneratorAlgorithm();

  for (int i = 0; i < 100; i++) {
    print(generator.generateCPF());
  }
}
