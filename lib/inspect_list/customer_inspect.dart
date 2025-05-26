import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

import '../db/mongodb.dart';
import '../lists/customer_list.dart';

class CustomerInspect extends StatefulWidget {
  final snap;
  final id;
  const CustomerInspect({super.key, required this.snap, required this.id});

  @override
  State<CustomerInspect> createState() => _CustomerInspectState();
}

class _CustomerInspectState extends State<CustomerInspect> {
  var data;
  Future<List<Map<String, dynamic>>> getcustomers() async {
    data = Connector.getcustomersPriveteOrders(widget.id);
    return data;
  }

  deleteOrders() async {
    Connector.deleteOrders(widget.id);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          //  mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'CUSTOMER DETAILS',
              style: TextStyle(
                  fontSize: 19,
                  fontStyle: FontStyle.italic,
                  color: Color.fromARGB(255, 38, 190, 7),
                  fontWeight: FontWeight.w700),
            ),
            Card(
              child: Container(
                color: Color.fromARGB(255, 233, 232, 232),
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
                height: 300,
                width: double.infinity,
                child: Row(
                  //  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Name                   :  ${widget.snap['cusname']}',
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w800),
                          ),
                          const Spacer(),
                          Text(
                            'Phone                  :  ${widget.snap['cusnumber']}',
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          const Spacer(),
                          Text(
                            'Price                     :  ₹${widget.snap['cusprice']}',
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          const Spacer(),
                          Text(
                            'Deposite              :  ₹${widget.snap['cusdeposite']}',
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          const Spacer(),
                          Text(
                            'JoinDate              :  ${DateFormat.yMMMd().format(widget.snap['cusjiondate'])}',
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          const Spacer(),
                          Text(
                            'Send SMS            :  ${widget.snap['sms']}',
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          const Spacer(),
                          Text(
                            'Last Order            :  ₹${widget.snap['lastorder']}',
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          const Spacer(),
                          Text(
                            'Total Order           :  ₹${widget.snap['totalorder']}',
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          const Spacer(),
                          Text(
                            'Debt Money         :  ₹${widget.snap['depitmoney']}',
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          const Spacer(),
                          Text(
                            'Current Holding Cans        :  ${widget.snap['holdingcans']}',
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          const Spacer(),
                          Text(
                            'Address ',
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(255, 38, 190, 7),
                                overflow: TextOverflow.clip),
                          ),
                          Text(
                            '${widget.snap['cusaddress']}',
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                overflow: TextOverflow.clip),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                const Text(
                  'HISTORY',
                  style: TextStyle(
                      fontSize: 19,
                      fontStyle: FontStyle.italic,
                      color: Color.fromARGB(255, 38, 190, 7),
                      fontWeight: FontWeight.w700),
                ),
                Spacer(),
                IconButton(
                    splashRadius: 25,
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: ((context) => AlertDialog(
                                content: const Text('Delete order?'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text(
                                        'No',
                                        style: TextStyle(color: Colors.green),
                                      )),
                                  TextButton(
                                      onPressed: () {
                                        deleteOrders();
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text(
                                        'Yes',
                                        style: TextStyle(color: Colors.red),
                                      )),
                                ],
                              )));
                    },
                    icon: const Icon(Icons.delete))
              ],
            ),
            Expanded(
              child: FutureBuilder(
                  future: getcustomers(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Color.fromARGB(255, 243, 177, 33),
                        ),
                      );
                    }

                    return Expanded(
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1, childAspectRatio: 1.9),
                          itemCount: snapshot.data.length,
                          itemBuilder: (ctx, index) {
                            var data = snapshot.data[index];
                            var style = const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500);
                            return Card(
                              color: Color.fromARGB(255, 116, 190, 190),
                              child: Container(
                                width: 200,
                                padding: EdgeInsets.all(8),
                                height: 180,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(3),
                                        child: Row(
                                          children: [
                                            Text(
                                                ' ${DateFormat.yMMMd().format(data['time'])}',
                                                style: style),
                                            Spacer(),
                                            Text(
                                                ' ${DateFormat('hh:mm a').format(data['time'].toLocal())}',
                                                style: style),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Text(
                                        'Order             : ${data['lastorder']}',
                                        style: style),
                                    Text(
                                        'T Order          : ${data['totalorder']}',
                                        style: style),
                                    Text(
                                        'M Recived     : ${data['gededmoney']}',
                                        style: style),
                                    Text(
                                        'C Recived      : ${data['getedcans']}',
                                        style: style),
                                    Text(
                                        'M Debt           : ${data['depitmoney']}',
                                        style: style),
                                    Text(
                                        'C in Hold        : ${data['holdingcans']}',
                                        style: style),
                                  ],
                                ),
                              ),
                            );
                          }),
                    );
                  }),
            ),
          ],
        ),
      )),
    );
  }
}
