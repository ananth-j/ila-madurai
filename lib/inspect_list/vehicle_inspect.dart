import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VehicleInspect extends StatefulWidget {
  final snap;
  final id;
  const VehicleInspect({super.key, required this.snap, required this.id});

  @override
  State<VehicleInspect> createState() => _VehicleInspectState();
}

class _VehicleInspectState extends State<VehicleInspect> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text(
                'VEHICLE DETAILS',
                style:  TextStyle(
                    fontSize: 19,
                    fontStyle: FontStyle.italic,
                    color: Color.fromARGB(255, 38, 190, 7),
                    fontWeight: FontWeight.w700),
              ),
              Card(
                child: Container(
                  color: const Color.fromARGB(255, 233, 232, 232),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                  height: 300,
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Name                :   ${widget.snap['vehname']}',
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w700),
                          ),
                          const Spacer(),
                          Text(
                            'No                      :   ${widget.snap['vehnumber']}',
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          const Spacer(),
                          Text(
                            'Capacity            :   ${widget.snap['capacity']}',
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                          const Spacer(),
                          Text(
                            'Last Service     :   ${DateFormat.yMMMd().format(widget.snap['serviceddate'].toDate())}',
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          const Spacer(),
                          Text(
                            'Next Service     :   ${DateFormat.yMMMd().format(widget.snap['nextservice'].toDate())}',
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          const Spacer(),
                          Text(
                            'Chase No          :   ${widget.snap['chasenumber']}',
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          const Spacer(),
                          Text(
                            'Engine No         :   ${widget.snap['enginenumber']}',
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          const Spacer(),
                          Text(
                            'Fuel Type          :   ${widget.snap['fuel']}',
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          const Spacer(),
                          Text(
                            'Empty                :   ${widget.snap['empty']}',
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          const Spacer(),
                          Text(
                            'Filled                  :   ${widget.snap['fill']}',
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          const Spacer(),
                          Text(
                            'Total Debt        :   ₹${widget.snap['depitmoney']}',
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          const Spacer(),
                          Text(
                            'Today Collection     :   ₹${widget.snap['todaycollection']}',
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          const Spacer(),
                          Text(
                            'Total Collection       :   ₹${widget.snap['totalcollection']}',
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
