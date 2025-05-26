import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EmployeeInspect extends StatefulWidget {
  final snap;
  final id;
  const EmployeeInspect({super.key, required this.snap, required this.id});

  @override
  State<EmployeeInspect> createState() => _EmployeeInspectState();
}

class _EmployeeInspectState extends State<EmployeeInspect> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
             const Text(
                'EMPLOYEE DETAILS',
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
                  height: 250,
                  width: double.infinity,
                  child: Row(
                    //  mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Name                       : ${widget.snap['empname']}',
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                          const Spacer(),
                          Text(
                            'Phone                      : ${widget.snap['empphone']}',
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          const Spacer(),
                          Text(
                            'Designation            : ${widget.snap['desingnation']}',
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          const Spacer(),
                          Text(
                            'Address                   : ${widget.snap['empaddress']}',
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                          const Spacer(),
                          Text(
                            'Salary                       : ₹${widget.snap['empsalary']}',
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          const Spacer(),
                          Text(
                            'Gender                     : ${widget.snap['empgender']}',
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          const Spacer(),
                          Text(
                            'Exprience                 : ${widget.snap['exprience']} Years ',
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          const Spacer(),
                          Text(
                            'Joined Date             : ${DateFormat.yMMMd().format(widget.snap['empjiondate'].toDate())}',
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          const Spacer(),
                          Text(
                            'Working Hours        : ${widget.snap['workinghrs']}',
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          const Spacer(),
                          Text(
                            'Age                            : ${widget.snap['empage']}',
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
