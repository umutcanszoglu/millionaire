class Prices {
  static final moneys = <String>[
    "500 £",
    "1K £",
    "5K £",
    "10K £",
    "40K £",
    "75K £",
    "100K £",
    "225K £",
    "350K £",
    "500K £",
    "700K £",
    "1M £",
  ];
}

class PhoneJoker {
  PhoneJoker(this.name, this.photo);
  final String name;
  final String photo;
  static final jokers = <PhoneJoker>[
    PhoneJoker("İlber Ortaylı", "assets/user2.jpg"),
    PhoneJoker("Mehmet Oz", "assets/user1.jpg"),
    PhoneJoker("Celal Şengör", "assets/user3.jpg"),
  ];
}
