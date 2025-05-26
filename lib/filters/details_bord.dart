import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailBoardModeFilter extends StatefulWidget {
  final data;
  const DetailBoardModeFilter({super.key, required this.data});

  @override
  State<DetailBoardModeFilter> createState() => _DetailBoardModeFilterState();
}

class _DetailBoardModeFilterState extends State<DetailBoardModeFilter> {
  DateTime currentTime = DateTime.now();
  Map<String, dynamic> samp = {};

  var Xtodayfilter;
  var Xlast7daysfilter;
  var Xthismonthfilter;
  var Xthisyearfilter;
  todayfilter() {
    var data = widget.data.data;
    int orders = 0,
        moneyRecived = 0,
        givedCans = 0,
        canRecived = 0,
        debitMoney = 0,
        totalorder = 0;
    for (int i = 0; i < data.length; i++) {
      var sundata = data[i];
      DateTime jiondate = sundata['time'];
      if (jiondate.day == currentTime.day &&
          jiondate.month == currentTime.month &&
          jiondate.year == currentTime.year) {
        orders = sundata['lastorder'] + orders;
        moneyRecived = sundata['gededmoney'] + moneyRecived;
        givedCans = sundata['filledcans'] + givedCans;
        canRecived = sundata['getedcans'] + canRecived;
        debitMoney = sundata['depitmoney'] + debitMoney;
      }
    }
    samp = {
      'order': orders,
      'moneyRecived': moneyRecived,
      'givedCans': givedCans,
      'canRecived': canRecived,
      'debitMoney': debitMoney,
    };
    return samp;
  }

  last7daysfilter() {
    var data = widget.data.data;
    int orders = 0,
        moneyRecived = 0,
        givedCans = 0,
        canRecived = 0,
        debitMoney = 0,
        totalorder = 0;
    for (int i = 0; i < data.length; i++) {
      var sundata = data[i];
      DateTime jiondate = sundata['time'];
      if (jiondate.weekday <= currentTime.weekday) {
        orders = sundata['lastorder'] + orders;
        moneyRecived = sundata['gededmoney'] + moneyRecived;
        givedCans = sundata['filledcans'] + givedCans;
        canRecived = sundata['getedcans'] + canRecived;
        debitMoney = sundata['depitmoney'] + debitMoney;
      }
    }
    samp = {
      'order': orders,
      'moneyRecived': moneyRecived,
      'givedCans': givedCans,
      'canRecived': canRecived,
      'debitMoney': debitMoney,
    };
    print("7 DAYS : $samp");
    return samp;
  }

  thismonthfilter() {
    var data = widget.data.data;
    int orders = 0,
        moneyRecived = 0,
        givedCans = 0,
        canRecived = 0,
        debitMoney = 0,
        totalorder = 0;
    for (int i = 0; i < data.length; i++) {
      var sundata = data[i];
      DateTime jiondate = sundata['time'];
      if (jiondate.month == currentTime.month &&
          jiondate.year == currentTime.year) {
        orders = sundata['lastorder'] + orders;
        moneyRecived = sundata['gededmoney'] + moneyRecived;
        givedCans = sundata['filledcans'] + givedCans;
        canRecived = sundata['getedcans'] + canRecived;
        debitMoney = sundata['depitmoney'] + debitMoney;
      }
    }
    samp = {
      'order': orders,
      'moneyRecived': moneyRecived,
      'givedCans': givedCans,
      'canRecived': canRecived,
      'debitMoney': debitMoney,
    };
    print('MONTH : $samp');
    return samp;
  }

  thisyearfilter() {
    var data = widget.data.data;
    int orders = 0,
        moneyRecived = 0,
        givedCans = 0,
        canRecived = 0,
        debitMoney = 0,
        totalorder = 0;
    for (int i = 0; i < data.length; i++) {
      var sundata = data[i];
      DateTime jiondate = sundata['time'];
      if (jiondate.year == currentTime.year) {
        orders = sundata['lastorder'] + orders;
        moneyRecived = sundata['gededmoney'] + moneyRecived;
        givedCans = sundata['filledcans'] + givedCans;
        canRecived = sundata['getedcans'] + canRecived;
        debitMoney = sundata['depitmoney'] + debitMoney;
      }
    }
    samp = {
      'order': orders,
      'moneyRecived': moneyRecived,
      'givedCans': givedCans,
      'canRecived': canRecived,
      'debitMoney': debitMoney,
    };
    print('YEAR : $samp');

    return samp;
  }

  @override
  void initState() {
    Xtodayfilter = todayfilter();
    Xlast7daysfilter = last7daysfilter();
    Xthismonthfilter = thismonthfilter();
    Xthisyearfilter = thisyearfilter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle stlye = const TextStyle(
        color: Color.fromARGB(255, 0, 0, 0),
        fontSize: 15,
        fontWeight: FontWeight.w500);
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TODAY SELLS
            // const SizedBox(height: 15),

            const Text(
              '  TODAY SALES  ',
              style: TextStyle(
                  color: Color.fromARGB(255, 27, 136, 13),
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              child: Container(
                padding: EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 228, 227, 227),
                  borderRadius: BorderRadius.circular(2),
                ),
                height: 115,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'TOTAL ORDER',
                          style: stlye,
                        ),
                        const SizedBox(
                          width: 108,
                        ),
                        Text(
                          ':  ₹${Xtodayfilter['order']}',
                          style: stlye,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'RECEIVED MONEY',
                          style: stlye,
                        ),
                        const SizedBox(
                          width: 81,
                        ),
                        Text(
                          ':  ₹${Xtodayfilter['moneyRecived']}',
                          style: stlye,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'DELIVERID CANS',
                          style: stlye,
                        ),
                        const SizedBox(
                          width: 89,
                        ),
                        Text(
                          ':    ${Xtodayfilter['givedCans']}',
                          style: stlye,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'RECEIVED CANS',
                          style: stlye,
                        ),
                        const SizedBox(
                          width: 93,
                        ),
                        Text(
                          ':    ${Xtodayfilter['canRecived']}',
                          style: stlye,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // LAST 7 DAYS
            const Spacer(),

            const SizedBox(height: 15),

            const Text(
              '  WEEKLY SALES  ',
              style: TextStyle(
                  color: Color.fromARGB(255, 27, 136, 13),
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              child: Container(
                padding: EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 228, 227, 227),
                  borderRadius: BorderRadius.circular(2),
                ),
                height: 115,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'TOTAL ORDER',
                          style: stlye,
                        ),
                        const SizedBox(
                          width: 108,
                        ),
                        Text(
                          ':  ₹${Xlast7daysfilter['order']}',
                          style: stlye,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'RECEIVED MONEY',
                          style: stlye,
                        ),
                        const SizedBox(
                          width: 81,
                        ),
                        Text(
                          ':  ₹${Xlast7daysfilter['moneyRecived']}',
                          style: stlye,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'DELIVERID CANS',
                          style: stlye,
                        ),
                        const SizedBox(
                          width: 89,
                        ),
                        Text(
                          ':    ${Xlast7daysfilter['givedCans']}',
                          style: stlye,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'RECEIVED CANS',
                          style: stlye,
                        ),
                        const SizedBox(
                          width: 93,
                        ),
                        Text(
                          ':    ${Xlast7daysfilter['canRecived']}',
                          style: stlye,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // THIS MONTH
            const Spacer(),
            const SizedBox(height: 15),

            const Text(
              '  MONTHLY SALES  ',
              style: TextStyle(
                  color: Color.fromARGB(255, 27, 136, 13),
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              child: Container(
                padding: EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 228, 227, 227),
                  borderRadius: BorderRadius.circular(2),
                ),
                height: 115,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'TOTAL ORDER',
                          style: stlye,
                        ),
                        const SizedBox(
                          width: 108,
                        ),
                        Text(
                          ':  ₹${Xthismonthfilter['order']}',
                          style: stlye,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'RECEIVED MONEY',
                          style: stlye,
                        ),
                        const SizedBox(
                          width: 81,
                        ),
                        Text(
                          ':  ₹${Xthismonthfilter['moneyRecived']}',
                          style: stlye,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'DELIVERID CANS',
                          style: stlye,
                        ),
                        const SizedBox(
                          width: 89,
                        ),
                        Text(
                          ':    ${Xthismonthfilter['givedCans']}',
                          style: stlye,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'RECEIVED CANS',
                          style: stlye,
                        ),
                        const SizedBox(
                          width: 93,
                        ),
                        Text(
                          ':    ${Xthismonthfilter['canRecived']}',
                          style: stlye,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // THIS YEAR
            const Spacer(),

            const SizedBox(height: 15),
            const Text(
              '  YEARLY SALES  ',
              style: TextStyle(
                  color: Color.fromARGB(255, 27, 136, 13),
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              child: Container(
                padding: EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 228, 227, 227),
                  borderRadius: BorderRadius.circular(2),
                ),
                height: 115,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'TOTAL ORDER',
                          style: stlye,
                        ),
                        const SizedBox(
                          width: 108,
                        ),
                        Text(
                          ':  ₹${Xthisyearfilter['order']}',
                          style: stlye,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'RECEIVED MONEY',
                          style: stlye,
                        ),
                        const SizedBox(
                          width: 81,
                        ),
                        Text(
                          ':  ₹${Xthisyearfilter['moneyRecived']}',
                          style: stlye,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'DELIVERID CANS',
                          style: stlye,
                        ),
                        const SizedBox(
                          width: 89,
                        ),
                        Text(
                          ':    ${Xthisyearfilter['givedCans']}',
                          style: stlye,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'RECEIVED CANS',
                          style: stlye,
                        ),
                        const SizedBox(
                          width: 93,
                        ),
                        Text(
                          ':    ${Xthisyearfilter['canRecived']}',
                          style: stlye,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
