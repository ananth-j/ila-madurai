class VehicleJson {
  final name;
  final number;
  final chaseno;
  final engineno;
  final capacity;
  final fueltype;
  final serviceddate;
  final nextservice;
  VehicleJson({
    required this.name,
    required this.engineno,
    required this.number,
    required this.capacity,
    required this.chaseno,
    required this.fueltype,
    required this.nextservice,
    required this.serviceddate,
  });
  Map<String, dynamic> toJson() => {
        "vehname": name,
        "vehnumber": number,
        "chasenumber": chaseno, 
        "enginenumber": engineno,
        "capacity": capacity,
        "fuel": fueltype,
        "serviceddate": serviceddate,
        "nextservice": nextservice,
        'empty': 0,
        'fill': 0,
        'todaycollection': 0,
        'totalcollection': 0,
        'depitmoney': 0,
        'gededmoney': 0,
        'closingfill': 0,
        'closingempty': 0,
        'remainig': 0,
      };
}
