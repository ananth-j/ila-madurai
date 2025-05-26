import 'package:flutter/material.dart';
import 'package:ila/lists/sales_inspect_list.dart';

import '../logics/sales_logic.dart';
import '../res/minitextfeild.dart';

class SalesVehicleList extends StatefulWidget {
  final id;
  final data;
  const SalesVehicleList({super.key, required this.data, required this.id});

  @override
  State<SalesVehicleList> createState() => _SalesVehicleListState();
}

class _SalesVehicleListState extends State<SalesVehicleList> {
  TextEditingController fillController = TextEditingController();
  TextEditingController emptyController = TextEditingController();
  TextEditingController todaycollection = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Inspect vehicle sales
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SalesInspectScreen(
                  snap: widget.data,
                  vid: widget.id,
                )));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
        child: Container(
          height: 40,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Color.fromARGB(237, 208, 252, 255),
              borderRadius: BorderRadius.circular(7)),
          child: Row(
            children: [
              SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 100,
                child: Text(widget.data['vehname'],
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 16)),
              ),
              Text('F : ${widget.data['closingfill']}',
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Color.fromARGB(255, 13, 214, 24))),
              const Spacer(flex: 1),
              Text('E : ${widget.data['closingempty']}',
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.red)),
              const Spacer(flex: 1),
              Text('TDC : ₹${widget.data['todaycollection']}',
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.purple)),
              IconButton(
                  splashRadius: 25,
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Row(
                                children: [
                                  const Text('Edit'),
                                  Spacer(),
                                  IconButton(
                                      onPressed: () {
                                        SalesLogic obj = SalesLogic();
                                        obj.mainScreenLogic(
                                          todaycollection.text,
                                          fillController.text,
                                          emptyController.text,
                                          widget.id,
                                        );
                                        Navigator.of(context).pop();
                                        fillController.text = '0';
                                        emptyController.text = '0';
                                      },
                                      splashRadius: 20,
                                      icon: const Icon(
                                        Icons.add_chart_outlined,
                                        size: 30,
                                        color:
                                            Color.fromARGB(255, 185, 11, 228),
                                      )),
                                ],
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  MiniTextFeild(
                                    width: 90,
                                    controller: todaycollection,
                                    hint: 'TDC',
                                    keybord: TextInputType.number,
                                  ),
                                  const SizedBox(height: 15),
                                  MiniTextFeild(
                                    width: 90,
                                    controller: fillController,
                                    hint: 'Fill',
                                    keybord: TextInputType.number,
                                  ),
                                  const SizedBox(height: 15),
                                  MiniTextFeild(
                                    width: 90,
                                    controller: emptyController,
                                    hint: 'Empty',
                                    keybord: TextInputType.number,
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          splashRadius: 20,
                                          icon: const Icon(
                                            Icons.close,
                                            size: 30,
                                            color: Color.fromARGB(
                                                255, 226, 27, 13),
                                          )),
                                      const Spacer(),
                                      IconButton(
                                          onPressed: () {
                                            SalesLogic obj = SalesLogic();
                                            obj.mainScreenSuperLogic(
                                              todaycollection.text,
                                              fillController.text,
                                              emptyController.text,
                                              widget.id,
                                            );
                                            Navigator.of(context).pop();
                                            fillController.text = '0';
                                            emptyController.text = '0';
                                          },
                                          splashRadius: 20,
                                          icon: const Icon(
                                            Icons.check,
                                            size: 30,
                                            color: Color.fromARGB(
                                                255, 11, 228, 18),
                                          )),
                                    ],
                                  )
                                ],
                              ),
                            ));
                  },
                  icon: Icon(Icons.edit))
            ],
          ),
        ),
      ),
    );
  }
}
