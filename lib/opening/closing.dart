import 'package:flutter/material.dart';

class ClosingWidget extends StatefulWidget {
  final snap;
  const ClosingWidget({super.key,required this.snap});

  @override
  State<ClosingWidget> createState() => _ClosingWidgetState();
}

class _ClosingWidgetState extends State<ClosingWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration:
            const BoxDecoration(color: Color.fromARGB(255, 4, 139, 110)),
        height: 50,
        width: double.infinity,
        child: Row(
          children: [
            const SizedBox(width: 10),
            Text(
              '${widget.snap['vehname']}',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            const Spacer(flex: 1),
            Text('Closing   F : ${widget.snap['closingfill']}',
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Color.fromARGB(255, 170, 214, 13))),
            const Spacer(flex: 1),
            Text('E : ${widget.snap['closingempty']}',
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Color.fromARGB(255, 192, 32, 21))),
            const Spacer(flex: 1),
            const Spacer(flex: 1),
            Text('TDC : ₹${widget.snap['todaycollection']}',
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Color.fromARGB(225, 13, 221, 211))),
            const Spacer(flex: 1),
          ],
        ),
      );
  }
}