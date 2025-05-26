import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../db/mongodb.dart';
import '../res/textfeild.dart';

class CustomerForm extends StatefulWidget {
  const CustomerForm({super.key});

  @override
  State<CustomerForm> createState() => _CustomerFormState();
}

class _CustomerFormState extends State<CustomerForm> {
  TextEditingController cusname = TextEditingController();
  TextEditingController cusphone = TextEditingController();
  TextEditingController cusaddress = TextEditingController();
  TextEditingController deposite = TextEditingController();
  TextEditingController canprice = TextEditingController();
  DateTime dateofjion = DateTime.now();
  int sms = 1;
  bool isLoading = false;
  @override
  void initState() {
    cusname = TextEditingController();
    cusphone = TextEditingController();
    cusaddress = TextEditingController();
    deposite = TextEditingController();
    canprice = TextEditingController();
    dateofjion = DateTime.now();
    super.initState();
  }

  thiscreateCustomer() async {
    setState(() {
      isLoading = true;
    });
    String res = '';
    //  Connector create = Connector(); //  CustomerLogic object
    res = await Connector.createCustomer(
      // Create customer
      cusname.text,
      cusphone.text,
      cusaddress.text,
      deposite.text,
      canprice.text,
      dateofjion,
      sms,
    );
    setState(() {
      isLoading = false;
    });
    if (res == 'success') {
      // ignore: use_build_context_synchronously
      showDialog(
          context: context,
          builder: ((context) => AlertDialog(
                backgroundColor: const Color.fromARGB(255, 6, 204, 12),
                content: const Text(
                  'Successfully new customer added',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                      child: const Text('ok'))
                ],
              )));
    } else {
      // ignore: use_build_context_synchronously
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 224, 224, 224)),
                    height: 50,
                    child: Row(
                      children: [
                        const SizedBox(width: 20),
                        IconButton(
                          splashRadius: 20,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Colors.red,
                          ),
                        ),
                        const Spacer(),
                        const Text('Add Customer',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 17, 47, 219))),
                        const Spacer(),
                        IconButton(
                          splashRadius: 20,
                          onPressed: () {
                            thiscreateCustomer();
                          },
                          icon: const Icon(Icons.check, color: Colors.green),
                        ),
                        const SizedBox(width: 20),
                      ],
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFeildDub(
                      controller: cusname,
                      hint: 'customer name',
                      keybord: TextInputType.text),
                  const SizedBox(height: 7),
                  TextFeildDub(
                      controller: cusphone,
                      hint: 'phone',
                      keybord: TextInputType.number),
                  const SizedBox(height: 7),
                  TextFeildDub(
                      controller: cusaddress,
                      hint: 'address',
                      keybord: TextInputType.text),

                  const SizedBox(height: 7),
                  TextFeildDub(
                      controller: canprice,
                      hint: 'price',
                      keybord: TextInputType.number),
                  const SizedBox(height: 7),
                  TextFeildDub(
                      controller: deposite,
                      hint: 'deposite',
                      keybord: TextInputType.number),
                  const SizedBox(height: 7),
                  // date picker
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Join Date  : ${dateofjion.day}:${dateofjion.month}:${dateofjion.year}',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                      Spacer(),
                      TextButton(
                        onPressed: () {
                          showCupertinoModalPopup(
                            context: context,
                            builder: ((context) => SizedBox(
                                  height: 300,
                                  child: CupertinoDatePicker(
                                    maximumDate: DateTime(2040),
                                    minimumDate: DateTime(2020),
                                    initialDateTime: dateofjion,
                                    mode: CupertinoDatePickerMode.date,
                                    backgroundColor: Colors.white,
                                    onDateTimeChanged: (DateTime newTime) {
                                      setState(() {
                                        dateofjion = newTime;
                                      });
                                    },
                                  ),
                                )),
                          );
                        },
                        child: const Text('Edit date'),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'Send SMS : ',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        RadioMenuButton(
                          style: ButtonStyle(
                              overlayColor:
                                  MaterialStatePropertyAll(Colors.transparent)),
                          value: 1,
                          groupValue: sms,
                          onChanged: (value) {
                            setState(() {
                              sms = value!;
                            });
                          },
                          child: const Text('No'),
                        ),
                        Spacer(),
                        RadioMenuButton(
                          style: ButtonStyle(
                              overlayColor:
                                  MaterialStatePropertyAll(Colors.transparent)),
                          value: 2,
                          groupValue: sms,
                          onChanged: (value) {
                            setState(() {
                              sms = value!;
                            });
                          },
                          child: const Text('Yes'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
