import 'dart:convert';

class CustomerJson {
  final name;
  final number;

  final price;
  final deposite;
  final jiondate;
  final address;
  final sms;
  const CustomerJson({
    required this.name,
    required this.address,
    required this.deposite,
    required this.jiondate,
    required this.number,
    required this.price,
    required this.sms, 
  });

  Map<String, dynamic> toMap() => {
        "cusname": name,
        "cusnumber": number,
        "cusprice": price,
        "cusdeposite": deposite,
        "cusjiondate":  jiondate,
        "cusaddress": address,
        'sms': sms,
        'holdingcans': 0,
        'lastorder': 0,
        'depitmoney': 0,
        'totalorder': 0,
      };
      String toJson() => json.encode(toMap());
}
