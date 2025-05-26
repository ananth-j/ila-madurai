class VehicleEditJson {
  final name;
  final number;
  final chaseno;
  final engineno;
  final capacity;
  final fueltype;
  final serviceddate;
  final nextservice;
  final totaldebit;
  final totalcollection;
  VehicleEditJson({
    required this.name,
    required this.engineno,
    required this.number,
    required this.capacity,
    required this.chaseno,
    required this.fueltype,
    required this.nextservice,
    required this.serviceddate,
    required this.totaldebit,
    required this.totalcollection,
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
        'depitmoney': totaldebit,
        'totalcollection': totalcollection,
      };
}
