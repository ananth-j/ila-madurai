import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ila/editpages/textfeild_debx.dart';

import '../res/textfeild.dart';
import 'logics/customer_edit_logic.dart';

class CustomerEditForm extends StatefulWidget {
  final id;
  final snap;
  const CustomerEditForm({super.key, required this.snap, required this.id});

  @override
  State<CustomerEditForm> createState() => _CustomerEditFormState();
}

class _CustomerEditFormState extends State<CustomerEditForm> {
  TextEditingController cusname = TextEditingController();
  TextEditingController cusphone = TextEditingController();
  TextEditingController cusaddress = TextEditingController();
  TextEditingController deposite = TextEditingController();
  TextEditingController canprice = TextEditingController();
  TextEditingController lastorder = TextEditingController();
  TextEditingController totalorder = TextEditingController();
  TextEditingController holdingcanes = TextEditingController();
  TextEditingController debitmoney = TextEditingController();
  DateTime dateofjion = DateTime.now();
  int sms = 1;
  bool isLoading = false;
  @override
  void initState() {
    dataSetter();
    cusname = TextEditingController();
    cusphone = TextEditingController();
    cusaddress = TextEditingController();
    deposite = TextEditingController();
    canprice = TextEditingController();
    // dateofjion = DateTime.now();
    dateofjion = DateTime.fromMillisecondsSinceEpoch(
        widget.snap['cusjiondate'].millisecondsSinceEpoch);
    super.initState();
  }

  thisEditCustomer() async {
    setState(() {
      isLoading = true;
    });
    String res = '';
    CustomerEditLogics obj = CustomerEditLogics();
    res = await obj.editCustomer(
        cusname.text,
        cusphone.text,
        cusaddress.text,
        deposite.text,
        canprice.text,
        dateofjion,
        sms,
        holdingcanes.text,
        totalorder.text,
        debitmoney.text,
        lastorder.text,
        widget.id);
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
                  'Successfully  customer detailes edited',
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

  dataSetter() {
    sms = widget.snap['sms'] == 'No' ? 1 : 2;
  }

  @override
  Widget build(BuildContext context) {
    // setState(() {
    cusname.text = widget.snap['cusname'];
    cusphone.text = widget.snap['cusnumber'];
    cusaddress.text = widget.snap['cusaddress'];
    deposite.text = widget.snap['cusdeposite'];
    canprice.text = '${widget.snap['cusprice']}';

    holdingcanes.text = '${widget.snap['holdingcans']}';

    totalorder.text = '${widget.snap['totalorder']}';
    debitmoney.text = '${widget.snap['depitmoney']}';
    lastorder.text = '${widget.snap['lastorder']}';
    // });
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
                        const Text('Edit Customer',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 17, 47, 219))),
                        const Spacer(),
                        IconButton(
                          splashRadius: 20,
                          onPressed: () {
                            thisEditCustomer();
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
                  TextFeildDubX(
                      controller: cusname,
                      hint: 'customer name',
                      keybord: TextInputType.text),
                  const SizedBox(height: 9),
                  TextFeildDubX(
                      controller: cusphone,
                      hint: 'phone',
                      keybord: TextInputType.number),
                  const SizedBox(height: 9),
                  TextFeildDubX(
                      controller: cusaddress,
                      hint: 'address',
                      keybord: TextInputType.text),

                  const SizedBox(height: 9),
                  TextFeildDubX(
                      controller: canprice,
                      hint: 'price',
                      keybord: TextInputType.number),
                  const SizedBox(height: 9),
                  TextFeildDubX(
                      controller: deposite,
                      hint: 'deposite',
                      keybord: TextInputType.number),
                  const SizedBox(height: 9),
                  TextFeildDubX(
                      controller: holdingcanes,
                      hint: 'HoldingCans',
                      keybord: TextInputType.number),
                  const SizedBox(height: 9),
                  TextFeildDubX(
                      controller: debitmoney,
                      hint: 'Debt',
                      keybord: TextInputType.number),
                  const SizedBox(height: 9),
                  TextFeildDubX(
                      controller: lastorder,
                      hint: 'L Order',
                      keybord: TextInputType.number),
                  const SizedBox(height: 9),
                  TextFeildDubX(
                      controller: totalorder,
                      hint: 'Total Order',
                      keybord: TextInputType.number),
                  const SizedBox(height: 9),
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
                          style: const ButtonStyle(
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
