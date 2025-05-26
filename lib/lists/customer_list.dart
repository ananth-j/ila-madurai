//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:ila/db/mongodb.dart';
//import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
//import '../editpages/customer_edit.dart';
//import '../inspect_list/customer_inspect.dart';
import '../editpages/customer_edit.dart';
import '../inspect_list/customer_inspect.dart';

class CustomerList extends StatefulWidget {
  final snap;
  final id;
  const CustomerList({super.key, required this.snap, required this.id});

  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  phonecaller(number) async {
    try {
      bool? res = await FlutterPhoneDirectCaller.callNumber(number);
    } catch (e) {}
  }

 @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CustomerInspect(
                  snap: widget.snap,
                  id: widget.id,
                )));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Card(
          color: Color.fromARGB(255, 233, 232, 232),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
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
                      'Name        :   ${widget.snap['cusname']}',
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w800),
                    ),
                    const Spacer(),
                    Text(
                      'Phone       :   ${widget.snap['cusnumber']}',
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    const Spacer(),
                    Container(
                      width: 250,
                      height: 17,
                      child: Text(
                        'Address    :   ${widget.snap['cusaddress']}',
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'Price         :   ₹${widget.snap['cusprice']}',
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  children: [
                    PopupMenuButton(
                      splashRadius: 17,
                      initialValue: 0,
                      itemBuilder: (context) => [
                        const PopupMenuItem(child: Text('edit'), value: 1),
                        const PopupMenuItem(child: Text('delete'), value: 2),
                      ],
                      onSelected: (value) {
                        if (value == 1) {
                          //  Calling Customer Editing form
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (contex) => CustomerEditForm(
                                    id: widget.id,
                                    snap: widget.snap,
                                  )));
                        }
                        if (value == 2) {
                          Connector.deleteCustomerProile(widget.id);
                        }
                      },
                    ),
                    IconButton(
                        splashRadius: 17,
                        onPressed: () {
                          phonecaller(widget.snap['cusnumber']);
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
