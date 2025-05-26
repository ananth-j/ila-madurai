import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ClassicModeFilter extends StatelessWidget {
  final data;
  const ClassicModeFilter({super.key, required this.data});
  time() {
    var timestamp = data['time'];

// Convert to 12-hour format time only
    String formattedTime = DateFormat('hh:mm a').format(timestamp.toLocal());
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    TextStyle stlye = TextStyle(
        color: Color.fromARGB(255, 0, 0, 0),
        fontSize: 15,
        fontWeight: FontWeight.w500);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(8),
        height: 125,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 201, 201, 201),
          //backgroundBlendMode: BlendMode.lighten,
          borderRadius: BorderRadius.circular(2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'ORDER',
                  style: stlye,
                ),
                SizedBox(
                  width: 137,
                ),
                Text(
                  ':      ₹${data['lastorder']}',
                  style: stlye,
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'GETED MONEY',
                  style: stlye,
                ),
                SizedBox(
                  width: 83,
                ),
                Text(
                  ':      ₹${data['gededmoney']}',
                  style: stlye,
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'CUSTOMER NAME',
                  style: stlye,
                ),
                SizedBox(
                  width: 59,
                ),
                Text(
                  ':      ${data['cusname']}',
                  style: stlye,
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'TIME',
                  style: stlye,
                ),
                SizedBox(
                  width: 149,
                ),
                Text(
                  ':      ${time()}',
                  style: stlye,
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'DATE',
                  style: stlye,
                ),
                SizedBox(
                  width: 147,
                ),
                Text(
                  ':      ${DateFormat.yMMMd().format(data['time'])}',
                  style: stlye,
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'VEHICLE',
                  style: stlye,
                ),
                SizedBox(
                  width: 124,
                ),
                Text(
                  ':      ${data['vname']}',
                  style: stlye,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
