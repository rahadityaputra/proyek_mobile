int getNeptuPancawara(int index) {
  const Map<int, int> neptuMap = {
    0: 5, // Legi
    1: 9, // Pahing
    2: 7, // Pon
    3: 4, // Wage
    4: 8, // Kliwon
  };

  return neptuMap[index] ?? 0;
}

int getNeptuSaptawara(int index) {
  const Map<int, int> neptuMap = {
    0: 9, // Saturday (Sebtu)
    1: 5, // Sunday (Akad)
    2: 4, // Monday (Senen)
    3: 3, // Tuesday (Selasa)
    4: 7, // Wednesday (Rebo)
    5: 8, // Thursday (Kemis)
    6: 6, // Friday (Jemah)
  };

  return neptuMap[index] ?? 0;
}

String getDinoSaptawara(int index) {
  const Map<int, String> dinoMap = {
    0: "Sebtu",
    1: "Akad",
    2: "Senen",
    3: "Selasa",
    4: "Rebo",
    5: "Kemis",
    6: "Jemah",
  };

  return dinoMap[index] ?? "";
}
