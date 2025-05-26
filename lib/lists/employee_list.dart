import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:ila/logics/employee_logic.dart';

import '../editpages/employee_edit.dart';
import '../inspect_list/employee_inspect.dart';

class EmployeeList extends StatefulWidget {
  final snap;
  final id;
  const EmployeeList({super.key, required this.id, required this.snap});

  @override
  State<EmployeeList> createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  phonecaller(number) async {
    try {
      bool? res = await FlutterPhoneDirectCaller.callNumber(number);
      print(res);
    } catch (e) {}
  }

  EmployeeLogic object = EmployeeLogic();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => EmployeeInspect(
                  snap: widget.snap,
                  id: widget.id,
                )));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Card(
          color: const Color.fromARGB(255, 233, 232, 232),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 7, vertical: 5),
            height: 106,
            width: double.infinity,
            child: Row(
              //  mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name        :  ${widget.snap['empname']}',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    Spacer(),
                    Text(
                      'Phone       :  ${widget.snap['empphone']}',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    Spacer(),
                    Text(
                      'Address    :  ${widget.snap['empaddress']}',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    Spacer(),
                    Text(
                      'Salary       : ₹${widget.snap['empsalary']}',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  children: [
                    PopupMenuButton(
                      splashRadius: 17,
                      itemBuilder: (context) => [
                        PopupMenuItem(child: Text('edit'), value: 1),
                        PopupMenuItem(child: Text('delete'), value: 2),
                      ],
                      onSelected: (value) {
                        if (value == 1) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: ((context) => EmployeeEditForm(
                                    id: widget.id,
                                    snap: widget.snap,
                                  ))));
                        } else if (value == 2) {
                          object.deleteEmployee(widget.id);
                        }
                      },
                    ),
                    IconButton(
                        splashRadius: 17,
                        onPressed: () {
                          phonecaller(widget.snap['empphone']);
                        },
                        icon: const Icon(Icons.call_outlined)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
