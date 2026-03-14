// based on https://github.com/thisham/javanese-weton/blob/master/src/index.ts

class ConversionResult {
  final String date;
  final WetonName wetonName;
  final WetonNumber wetonNumber;

  ConversionResult({
    required this.date,
    required this.wetonName,
    required this.wetonNumber,
  });
}

class WetonName {
  final String pancawara;
  final String saptawara;

  WetonName({required this.pancawara, required this.saptawara});
}

class WetonNumber {
  final int pancawara;
  final int saptawara;

  WetonNumber({required this.pancawara, required this.saptawara});
}

const Map<int, String> saptawaraList = {
  0: "Saturday",
  1: "Sunday",
  2: "Monday",
  3: "Tuesday",
  4: "Wednesday",
  5: "Thursday",
  6: "Friday",
};

const Map<int, String> pancawaraList = {
  0: "Legi",
  1: "Pahing",
  2: "Pon",
  3: "Wage",
  4: "Kliwon",
};

int _getGregorianDayOfTamYear(int tamYear) {
  int leapYearCycleRest = tamYear % 4;
  int leapYearCycle = ((tamYear - leapYearCycleRest) ~/ 4) * 1461;
  leapYearCycleRest = leapYearCycleRest * 365;
  int gregorianOfYear = leapYearCycle + leapYearCycleRest;
  return gregorianOfYear;
}

bool _isLeapYear(int year) {
  if (year % 400 == 0) return true;
  if (year % 100 == 0) return false;
  if (year % 4 == 0) return true;
  return false;
}

int _countGregorianDayOfLeapMonth(int month) {
  const dayOfMonth = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
  int gregorianDays = 0;
  for (int index = 0; index < month; index++) {
    gregorianDays = gregorianDays + dayOfMonth[index];
  }
  return gregorianDays;
}

int _countGregorianDayOfCommonMonth(int month) {
  const dayOfMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
  int gregorianDays = 0;
  for (int index = 0; index < month; index++) {
    gregorianDays = gregorianDays + dayOfMonth[index];
  }
  return gregorianDays;
}

int _getGregorianDayOfTamMonth(int tamMonth, int year) {
  if (_isLeapYear(year)) return _countGregorianDayOfLeapMonth(tamMonth);
  return _countGregorianDayOfCommonMonth(tamMonth);
}

int _gregorianDate(int year, int month, int day) {
  int tamYear = year - 1;
  int date = _getGregorianDayOfTamYear(tamYear);
  date = date + _getGregorianDayOfTamMonth(month, year);
  date = date + day;
  return date;
}

int _getPancawara(int gregorianDate) {
  return gregorianDate % 5;
}

int _getSaptawara(int gregorianDate) {
  return gregorianDate % 7;
}

ConversionResult getWeton(DateTime annoDominiDate) {
  bool aPrimitive = annoDominiDate.year <= 1900;
  bool aHumanoid = annoDominiDate.year >= 2100;

  if (aPrimitive || aHumanoid) {
    throw Exception("Only can get weton between 1900 AD. to 2100 AD.");
  }

  // DateTime.month is 1-indexed in Dart, while JS getMonth() is 0-indexed.
  int gregorianDays = _gregorianDate(
    annoDominiDate.year,
    annoDominiDate.month - 1,
    annoDominiDate.day,
  );

  int pancawara = _getPancawara(gregorianDays);
  int saptawara = _getSaptawara(gregorianDays);

  return ConversionResult(
    date: annoDominiDate.toString(),
    wetonName: WetonName(
      pancawara: pancawaraList[pancawara]!,
      saptawara: saptawaraList[saptawara]!,
    ),
    wetonNumber: WetonNumber(
      pancawara: pancawara,
      saptawara: saptawara,
    ),
  );
}
