class EmployeeJson {
  final name;
  final phone;
  final address;
  final gender;
  final salary;
  final exprience;
  final jiondate;
  final age;
  final id;
  final workinghrs;
  final desingnation;
  EmployeeJson(
      {required this.address,
      required this.age,
      required this.exprience,
      required this.gender,
      required this.id,
      required this.jiondate,
      required this.name,
      required this.phone,
      required this.salary,
      required this.workinghrs,
      required this.desingnation});

  Map<String, dynamic> toJson() => { 
        "empname": name,
        "empphone": phone,
        "empaddress": address,
        "empgender": gender,
        "empsalary": salary,
        "exprience": exprience,
        "empjiondate": jiondate,
        "empage": age,
        "empid": id,
        "workinghrs": workinghrs,
        'desingnation' : desingnation,
      };
}
