// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../db/mongodb.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

import '../filters/classic_mode.dart';
import '../filters/details_bord.dart';
import '../lists/customer_list.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  DateTimeRange pickedDate =
      DateTimeRange(start: DateTime.now(), end: DateTime(2030));
  DateTimeRange compreDate =
      DateTimeRange(start: DateTime.now(), end: DateTime(2030));
  TextEditingController searchKeyController = TextEditingController();
  int mode = 1;
  var ordereddata;
  var selectedOrderedData;
  var dateFilterSnapshot;
  String searchKey = '';
  List<Map<String, dynamic>> samp = [];

  static Future<List<Map<String, dynamic>>> getcustomers() async {
    var data = Connector.getOrders();
    return data;
  }

  @override
  void initState() {
    ordereddata = getcustomers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Total Order Report'),
        actions: [
          PopupMenuButton(
            splashRadius: 17,
            initialValue: 0,
            itemBuilder: (context) => [
              const PopupMenuItem(child: Text('Selected Days'), value: 1),
              const PopupMenuItem(child: Text('Search'), value: 2),
              const PopupMenuItem(child: Text('Sales Board '), value: 3),
            ],
            onSelected: (value) {
              try {
                if (value == 1) {
                  setState(() {
                    mode = 1;
                  });
                }
                if (value == 2) {
                  setState(() {
                    mode = 2;
                  });
                }
                if (value == 3) {
                  setState(() {
                    mode = 3;
                  });
                }
              } catch (e) {}
            },
          ),
        ],
      ),
      body: SafeArea(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          mode == 1
              ? Container(
                  height: 55,
                  padding: const EdgeInsets.all(2.0),
                  child: Card(
                      color: const Color.fromARGB(255, 46, 213, 235),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Row(
                          children: [
                            Text(
                              'Select Date : ${pickedDate.duration.inDays == compreDate.duration.inDays ? 0 : pickedDate.duration.inDays} days      ${samp.length == 0 ? 'No' : samp.length} Orders',
                              style: const TextStyle(
                                  fontSize: 17,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontWeight: FontWeight.w500),
                            ),
                            const Spacer(),
                            ElevatedButton(
                                onPressed: () async {
                                  try {
                                    final DateTimeRange? dateTimeRange =
                                        await showDateRangePicker(
                                      context: context,
                                      firstDate: DateTime(2022),
                                      lastDate: DateTime(2030),
                                    );
                                    if (dateTimeRange != null) {
                                      samp = [];
                                      setState(() {
                                        pickedDate = dateTimeRange;
                                      });
                                      for (int i = 0;
                                          i < dateFilterSnapshot.length;
                                          i++) {
                                        var sundata = dateFilterSnapshot[i];
                                        DateTime jiondate = sundata['time'];
                                        if (jiondate.isBefore(pickedDate.end) &&
                                            jiondate
                                                .isAfter(pickedDate.start)) {
                                          samp.add(sundata);
                                          print(samp.toString());
                                        }
                                      }
                                    }
                                  } catch (e) {}
                                },
                                child:
                                    const Icon(Icons.calendar_month_rounded)),
                          ],
                        ),
                      )),
                )
              : mode == 2
                  ? Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width * 0.94,
                            child: TextField(
                              keyboardType: TextInputType.text,
                              cursorHeight: 18,
                              style: TextStyle(),
                              onChanged: (value) {
                                setState(() {
                                  searchKey = value;
                                });
                              },
                              controller: searchKeyController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                hintText: 'Search',
                                hintStyle: TextStyle(
                                    color: Color.fromARGB(234, 0, 0, 0)),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: BorderSide(
                                      width: 1.5,
                                      color: Color.fromARGB(255, 10, 67, 223)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: BorderSide(
                                      width: 1.5,
                                      color:
                                          Color.fromARGB(255, 137, 163, 211)),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container(),
          Expanded(
            child: FutureBuilder(
                future: ordereddata,
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator(
                      color: Color.fromARGB(255, 243, 177, 33),
                    ));
                  }

                  if (snapshot.hasData) {
                    if (mode == 1) {
                      return ListView.builder(
                          itemCount:
                              samp.isEmpty ? snapshot.data.length : samp.length,
                          itemBuilder: (ctx, index) {
                            var Xdata;
                            if (samp.isEmpty) {
                              Xdata = snapshot.data[index];
                            } else {
                              Xdata = samp[index];
                            }
                            dateFilterSnapshot = snapshot.data;
                            print('2');

                            return ClassicModeFilter(
                              data: Xdata,
                            );
                          });
                    }
                    if (mode == 2) {
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (ctx, index) {
                            var Xdata = snapshot.data[index];
                            if (searchKey.isEmpty) {
                              return ClassicModeFilter(
                                data: Xdata,
                              );
                            }
                            if (Xdata.toString()
                                .toLowerCase()
                                .contains(searchKey.toLowerCase())) {
                              return ClassicModeFilter(
                                data: Xdata,
                              );
                            }
                            return Container();
                          });
                    }
                    if (mode == 3) {
                      var Xdata = snapshot;
                      return DetailBoardModeFilter(
                        data: Xdata,
                      );
                    }
                  }
                  return Container();
                }),
          ),
        ],
      )),
    );
  }
}
