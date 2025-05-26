import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

import '../db/mongodb.dart';
import '../logics/sales_logic.dart';
import '../logics/sales_model.dart';
import '../opening/closing.dart';

class SalesInspectScreen extends StatefulWidget {
  final snap;
  final vid;
  const SalesInspectScreen({super.key, required this.snap, required this.vid});

  @override
  State<SalesInspectScreen> createState() => _SalesInspectScreenState();
}

class _SalesInspectScreenState extends State<SalesInspectScreen> {
  String searchKey = '';
  bool isLoding = false;
  TextEditingController searchController = TextEditingController();
  TextEditingController filledController = TextEditingController();
  TextEditingController emptyController = TextEditingController();
  TextEditingController getmoneyhController = TextEditingController();
  TextEditingController debitcanController = TextEditingController();
  TextEditingController debitmoneyController = TextEditingController();
  var Xdata; // Selected customer detailes
  var Xdataid;
  var maindata;

  selectCustomer() {
    try {
      if (Xdata != null) {
        int price = int.parse('${Xdata['cusprice']}');
        int filledcans = 0;
        int gededcans = 0;
        int gededmoney = 0;

        if (emptyController.text != '') {
          gededcans = int.parse(emptyController.text);
        }
        if (getmoneyhController.text != '') {
          gededmoney = int.parse(getmoneyhController.text);
        }
        if (filledController.text != '') {
          filledcans = int.parse(filledController.text);
        }
        // main functions

        int currectbuyprice = price * filledcans;
        int emptyDebitCans = (Xdata['holdingcans'] + filledcans) - gededcans;
        int debitMoney = (Xdata['depitmoney'] + currectbuyprice) - gededmoney;
        int totalorder = Xdata['totalorder'] + currectbuyprice;
        if (debitMoney < 0) {
          debitMoney = 0;
        }
        if (emptyDebitCans < 0) {
          emptyDebitCans = 0;
        }
        if (filledcans < 0) {
          filledcans = 0;
        }
        if (gededmoney < 0) {
          gededmoney = 0;
        }
        if (gededcans < 0) {
          gededcans = 0;
        }

        setState(() {
          debitcanController.text = emptyDebitCans.toString();
          debitmoneyController.text = debitMoney.toString();
        });
        // Sending to sales model
        SalesModel obj = SalesModel(
          currectbuyprice: currectbuyprice,
          debitMoney: debitMoney,
          emptyDebitCans: emptyDebitCans,
          filledcans: filledcans,
          gededmoney: gededmoney,
          totalorder: totalorder,
          getedcans: gededcans,
          vid: widget.vid,
          vname: widget.snap['vehname'],
          cusid: Xdataid,
          cusname: Xdata['cusname'],
        );
        return obj.toJson();
      } else {
        print("somethig wrong");
        return null;
      }
    } catch (e) {}
    // enture values
  }

  undo(Xdata, Xdataid, vid) async {
    var res = '';
    //  ReDoLogic obj = ReDoLogic();
    // res = await obj.redologic(Xdata, Xdataid, vid);
    if (res == 'success') {
      showDialog(
          context: context,
          builder: ((context) => AlertDialog(
                backgroundColor: const Color.fromARGB(255, 6, 204, 12),
                title: const Text(
                  'Success',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 19),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('ok'))
                ],
              )));
    } else {
      showDialog(
          context: context,
          builder: ((context) => const AlertDialog(
                backgroundColor: Color.fromARGB(255, 233, 22, 7),
                content: Text(
                  'Something Wrong',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
              )));
    }
  }

  static Future<List<Map<String, dynamic>>> getcustomers() async {
    var data = Connector.getcustomers();
    return data;
  }

  getcustomersSubcallser() {
    setState(() {
      maindata = getcustomers();
    });
  }

  @override
  void initState() {
    //  vehicleData();
    getcustomersSubcallser();

    //Xdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // App bar
            Container(
              decoration: const BoxDecoration(color: Colors.purple),
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
                  Text('Opening   F : ${widget.snap['fill']}',
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Color.fromARGB(255, 13, 214, 24))),
                  const Spacer(flex: 1),
                  Text('E : ${widget.snap['empty']}',
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.red)),
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
            ),
            // BODY
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                children: [
                  // Search box
                  Container(
                    padding: const EdgeInsets.all(8),
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Color.fromARGB(255, 197, 197, 197)),
                    child: Column(
                      children: [
                        // Header BOX
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Search BOX
                            SizedBox(
                              height: 40,
                              width: 150,
                              child: TextField(
                                onChanged: (value) {
                                  setState(() {
                                    searchKey = value;
                                  });
                                },
                                keyboardType: TextInputType.text,
                                cursorHeight: 18,
                                style: const TextStyle(),
                                controller: searchController,
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  hintText: 'search',
                                  hintStyle: const TextStyle(
                                      color: Color.fromARGB(234, 0, 0, 0)),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: const BorderSide(
                                        width: 2,
                                        color:
                                            Color.fromARGB(255, 10, 67, 223)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: const BorderSide(
                                        width: 2,
                                        color:
                                            Color.fromARGB(255, 137, 163, 211)),
                                  ),
                                ),
                              ),
                            ),
                            // CONFORM THE ORDER
                            IconButton(
                                splashRadius: 25,
                                onPressed: () async {
                                  setState(() {
                                    isLoding = true;
                                  });
                                  // For Vehicle Edit
                                  if (Xdata != null) {
                                    SalesLogic obj = SalesLogic();
                                    await Connector.salesLogicsCustomer(Xdataid,
                                        selectCustomer()); // For Customer EDIT
                                    await obj.salesVehicleedit(widget.vid,
                                        selectCustomer(), widget.snap);
                                    setState(() {
                                      isLoding = false;
                                    });
                                    getcustomersSubcallser();
                                  }

                                  searchKey = '';
                                },
                                icon: const Icon(Icons.check,
                                    color: Color.fromARGB(255, 3, 199, 10))),
                            // REMOVE SELECTED CUSTOMER

                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    Xdata = null;
                                    Xdataid = null;
                                  });
                                  filledController.text = '';
                                  emptyController.text = '';
                                  getmoneyhController.text = '';
                                  searchKey = '';
                                },
                                icon: const Icon(Icons.close,
                                    color: Color.fromARGB(255, 221, 24, 10))),
                            // REDO BUTTON
                            IconButton(
                                splashRadius: 25,
                                onPressed: () {
                                  undo(Xdata, Xdataid, widget.vid);
                                  filledController.text = '';
                                  emptyController.text = '';
                                  getmoneyhController.text = '';
                                },
                                icon: const Icon(Icons.redo,
                                    color: Color.fromARGB(255, 255, 5, 192))),
                          ],
                        ),
                        // Customer Name PROVIDER
                        Xdata == null // Cheacking Xdata is not NULL
                            ? Container()
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Customer Name :  ${Xdata['cusname']}',
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600)),
                                  Text('price ₹${Xdata['cusprice']}',
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600)),
                                ],
                              ),
                        const Spacer(flex: 1),
                        // INPUT BOX
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 30,
                              width: 70,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                cursorHeight: 18,
                                controller: filledController,
                                onChanged: (value) {
                                  selectCustomer();
                                },
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  hintText: 'Filled',
                                  hintStyle: const TextStyle(
                                      color: Color.fromARGB(234, 0, 0, 0)),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: const BorderSide(
                                        width: 1.5,
                                        color: Color.fromARGB(255, 243, 4, 4)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: const BorderSide(
                                        width: 1.5,
                                        color: Color.fromARGB(255, 79, 236, 6)),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                              width: 70,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                cursorHeight: 18,
                                onChanged: (value) {
                                  selectCustomer();
                                },
                                controller: emptyController,
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  hintText: 'Empty',
                                  hintStyle: const TextStyle(
                                      color: Color.fromARGB(234, 0, 0, 0)),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: const BorderSide(
                                        width: 1.5,
                                        color: Color.fromARGB(255, 243, 4, 4)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: const BorderSide(
                                        width: 1.5,
                                        color: Color.fromARGB(255, 79, 236, 6)),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 30,
                              width: 90,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                cursorHeight: 18,
                                controller: getmoneyhController,
                                onChanged: (value) {
                                  selectCustomer();
                                },
                                decoration: InputDecoration(
                                  prefixText: '₹',
                                  fillColor: Colors.white,
                                  filled: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  hintText: 'Money',
                                  hintStyle: const TextStyle(
                                      color: Color.fromARGB(234, 0, 0, 0)),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: const BorderSide(
                                        width: 1.5,
                                        color: Color.fromARGB(255, 243, 4, 4)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: const BorderSide(
                                        width: 1.5,
                                        color: Color.fromARGB(255, 79, 236, 6)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(flex: 1),
                        // Disabled TextFeilds
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text('In Hold  :',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w600)),
                            const Spacer(flex: 1),
                            SizedBox(
                              height: 30,
                              width: 50,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                cursorHeight: 18,
                                controller: debitcanController,
                                enabled: false,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  hintStyle: const TextStyle(
                                      color: Color.fromARGB(234, 0, 0, 0)),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: const BorderSide(
                                        width: 1.5,
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                ),
                              ),
                            ),
                            const Spacer(flex: 5),
                            const Text('Debt  :',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w600)),
                            const Spacer(flex: 1),
                            SizedBox(
                              height: 30,
                              width: 90,
                              child: TextField(
                                enabled: false,
                                keyboardType: TextInputType.number,
                                cursorHeight: 18,
                                controller: debitmoneyController,
                                decoration: InputDecoration(
                                  prefixText: '₹',
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  hintStyle: const TextStyle(
                                      color: Color.fromARGB(234, 0, 0, 0)),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: const BorderSide(
                                        width: 1.5,
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Customer List
                ],
              ),
            ),
            FutureBuilder(

                /// Stream builder for customers list view
                future: maindata,
                builder: (context, AsyncSnapshot snapshot) {
                  if (isLoding == true) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(59),
                        child: CircularProgressIndicator(
                          color: Colors.blue,
                        ),
                      ),
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(59),
                        child: CircularProgressIndicator(
                          color: Color.fromARGB(255, 3, 185, 3),
                        ),
                      ),
                    );
                  }

                  return Flexible(
                    child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (ctx, index) {
                          var data = snapshot.data[index]; // actual snap data
                          // when search box is empty
                          // Befour search list
                          if (searchKey.isEmpty) {
                            return GestureDetector(
                              onTap: () {
                                Xdata = data; // setting search user detiles
                                Xdataid = data['_id']; // setting search user id
                                selectCustomer();
                                filledController.text = '';
                                emptyController.text = '';
                                getmoneyhController.text =
                                    ''; // calling search box logics
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 20),
                                child: Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      color: const Color.fromARGB(
                                          255, 233, 233, 233),
                                    ),
                                    child: Row(
                                      children: [
                                        const Spacer(flex: 1),
                                        Text(
                                          '${data['cusname']}',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Color.fromARGB(
                                                  255, 14, 206, 231)),
                                        ),
                                        const Spacer(flex: 1),
                                        Text(
                                          'L :  ₹${data['lastorder']}',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.red),
                                        ),
                                        const Spacer(flex: 1),
                                        Text(
                                          'H : ${data['holdingcans']}',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.blue),
                                        ),
                                        const Spacer(flex: 1),
                                        Text(
                                          'D : ₹${data['depitmoney']}',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Color.fromARGB(
                                                  255, 67, 197, 7)),
                                        ),
                                        const Spacer(flex: 1),
                                      ],
                                    )),
                              ),
                            );
                          }
                          // After search list
                          if (data
                              .toString()
                              .toLowerCase()
                              .contains(searchKey.toLowerCase())) {
                            // Search key words fillter
                            return GestureDetector(
                              onTap: () {
                                Xdata = data; // setting search user detiles
                                Xdataid = data['_id']; // setting search user id
                                selectCustomer(); // calling search box logics
                                filledController.text = '';
                                emptyController.text = '';
                                getmoneyhController.text = '';
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 20),
                                child: Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      color: const Color.fromARGB(
                                          255, 233, 233, 233),
                                    ),
                                    child: Row(
                                      children: [
                                        const Spacer(flex: 1),
                                        Text(
                                          '${data['cusname']}',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Color.fromARGB(
                                                  255, 14, 206, 231)),
                                        ),
                                        const Spacer(flex: 1),
                                        Text(
                                          'L : ₹${data['lastorder']}',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.red),
                                        ),
                                        const Spacer(flex: 1),
                                        Text(
                                          'H : ${data['holdingcans']}',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.blue),
                                        ),
                                        const Spacer(flex: 1),
                                        Text(
                                          'D : ₹${data['depitmoney']}',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Color.fromARGB(
                                                  255, 67, 197, 7)),
                                        ),
                                        const Spacer(flex: 1),
                                      ],
                                    )),
                              ),
                            );
                          }
                          return Container(); // return empty container
                        }),
                  );
                }),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 50,
        width: double.infinity,
        child: ClosingWidget(
          snap: widget.snap,
        ),
      ),
    );
  }
}
