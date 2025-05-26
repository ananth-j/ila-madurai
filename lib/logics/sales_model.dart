class SalesModel {
  final int debitMoney;
  final int emptyDebitCans;
  final int currectbuyprice;
  final int gededmoney;
  final int filledcans;
  final int totalorder;
  final int getedcans;
  final vid;
  final vname;
  final cusid;
  final cusname;
  SalesModel({
    required this.currectbuyprice,
    required this.debitMoney,
    required this.emptyDebitCans,
    required this.filledcans,
    required this.gededmoney,
    required this.totalorder,
    required this.getedcans,
    required this.vid,
    required this.vname,
    required this.cusid,
    required this.cusname,
  });
  Map<String, dynamic> toJson() => {
        'lastorder': currectbuyprice,
        'depitmoney': debitMoney,
        'holdingcans': emptyDebitCans,
        'totalorder': totalorder,
        'filledcans': filledcans,
        'gededmoney': gededmoney,
        'getedcans': getedcans,
        'time': DateTime.now(),
        'vid': vid,
        'vname': vname,
        'cusid': cusid,
        'cusname': cusname,
      };
}
