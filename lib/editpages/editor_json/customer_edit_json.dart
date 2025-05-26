import 'dart:convert';

class CustomerEditJson {
  final name;
  final number;

  final price;
  final deposite;
  final jiondate;
  final address;
  final sms;
  final lastOrder;
  final debitmoney;
  final totalorder;
  final holdingcans;

  const CustomerEditJson({
    required this.name,
    required this.address,
    required this.deposite,
    required this.jiondate,
    required this.number,
    required this.price,
    required this.sms,
    required this.holdingcans,
    required this.totalorder,
    required this.debitmoney,
    required this.lastOrder,
  });

  Map<String, dynamic> toMap() => {
        "cusname": name,
        "cusnumber": number,
        "cusprice": price,
        "cusdeposite": deposite,
        "cusjiondate": jiondate,
        "cusaddress": address,
        'sms': sms,
        'holdingcans': holdingcans,
        'lastorder': lastOrder,
        'depitmoney': debitmoney,
        'totalorder': totalorder,
      };
  String toJson() => json.encode(toMap());
}
