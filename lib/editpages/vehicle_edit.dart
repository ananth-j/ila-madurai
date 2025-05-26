import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ila/editpages/textfeild_debx.dart';

import '../logics/vehicle_logic.dart';
import 'logics/vehicle_edit_logic.dart';

class VehicleEditFrom extends StatefulWidget {
  final id;
  final snap;
  const VehicleEditFrom({super.key, required this.id, required this.snap});

  @override
  State<VehicleEditFrom> createState() => _VehicleEditFromState();
}

class _VehicleEditFromState extends State<VehicleEditFrom> {
  TextEditingController vehname = TextEditingController();

  TextEditingController vehnumber = TextEditingController();

  TextEditingController engno = TextEditingController();

  TextEditingController chaseno = TextEditingController();

  TextEditingController capacity = TextEditingController();

  TextEditingController debit = TextEditingController();
  TextEditingController totalcollection = TextEditingController();
  DateTime serviceddate = DateTime.now();
  DateTime nextservice = DateTime.now();

  @override
  void initState() {
    serviceddate = DateTime.fromMillisecondsSinceEpoch(
        widget.snap['serviceddate'].millisecondsSinceEpoch);
    nextservice = DateTime.fromMillisecondsSinceEpoch(
        widget.snap['nextservice'].millisecondsSinceEpoch);

    fuelselectedValue = widget.snap['fuel'] == 'Diesel' ? 1 : 2;
    super.initState();
  }

  int fuelselectedValue = 1;
  bool isLoading = false;
  thisaddvehicle() async {
    setState(() {
      isLoading = true;
    });
    String res;
    VehicleEditLogic obect = VehicleEditLogic();
    // create vehicle
    res = await obect.editVehicle(
      vehname.text,
      vehnumber.text,
      chaseno.text,
      engno.text,
      capacity.text,
      fuelselectedValue,
      serviceddate,
      nextservice,
      debit.text,
      totalcollection.text,
      widget.id,
    );
    setState(() {
      isLoading = false;
    });
    if (res == 'success') {
      showDialog(
          context: context,
          builder: ((context) => AlertDialog(
                backgroundColor: const Color.fromARGB(255, 6, 204, 12),
                content: const Text(
                  'Vehicle edited successfully',
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
    setState(() {
      vehname.text = widget.snap['vehname'];
      vehnumber.text = widget.snap['vehnumber'];
      chaseno.text = widget.snap['chasenumber'];
      engno.text = widget.snap['enginenumber'];
      capacity.text = widget.snap['capacity'];
      debit.text =  '${widget.snap['depitmoney'] }';
      totalcollection.text =  '${widget.snap['totalcollection']}'  ;
    });

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
                        const Text('Edit Vehicle',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 17, 47, 219))),
                        const Spacer(),
                        IconButton(
                          splashRadius: 20,
                          onPressed: () {
                            thisaddvehicle();
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
                      controller: vehname,
                      hint: 'Vehicle name',
                      keybord: TextInputType.text),
                  const SizedBox(height: 9),
                  TextFeildDubX(
                      controller: vehnumber,
                      hint: 'Vehicle No',
                      keybord: TextInputType.text),
                  const SizedBox(height: 9),
                  TextFeildDubX(
                      controller: engno,
                      hint: 'Engine No',
                      keybord: TextInputType.text),
                  const SizedBox(height: 9),
                  TextFeildDubX(
                      controller: chaseno,
                      hint: 'Chase No',
                      keybord: TextInputType.text),
                  const SizedBox(height: 9),
                  TextFeildDubX(
                      controller: capacity,
                      hint: 'Capacity',
                      keybord: TextInputType.number),
                  const SizedBox(height: 9),
                  TextFeildDubX(
                      controller: debit,
                      hint: 'Debt',
                      keybord: TextInputType.number),
                  const SizedBox(height: 9),
                  TextFeildDubX(
                      controller: totalcollection,
                      hint: 'T C',
                      keybord: TextInputType.number),
                  const SizedBox(height: 10),

                  // date picker
                  Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Seviced Date   : ${serviceddate.day}:${serviceddate.month}:${serviceddate.year}',
                        style: const TextStyle(
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
                                    initialDateTime: serviceddate,
                                    mode: CupertinoDatePickerMode.date,
                                    backgroundColor: Colors.white,
                                    onDateTimeChanged: (DateTime newTime) {
                                      setState(() {
                                        serviceddate = newTime;
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
                  Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Next Service    : ${nextservice.day}:${nextservice.month}:${nextservice.year}',
                        style: const TextStyle(
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
                                    initialDateTime: nextservice,
                                    mode: CupertinoDatePickerMode.date,
                                    backgroundColor: Colors.white,
                                    onDateTimeChanged: (DateTime newTime) {
                                      setState(() {
                                        nextservice = newTime;
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
                  // Fuel Type
                  SizedBox(
                    height: 40,
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'Fuel type : ',
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                        RadioMenuButton(
                          value: 1,
                          groupValue: fuelselectedValue,
                          onChanged: (value) {
                            setState(() {
                              fuelselectedValue = value!;
                            });
                          },
                          child: const Text('Diesel'),
                        ),
                        Spacer(),
                        RadioMenuButton(
                          value: 2,
                          groupValue: fuelselectedValue,
                          onChanged: (value) {
                            setState(() {
                              fuelselectedValue = value!;
                            });
                          },
                          child: const Text('Petrol'),
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
