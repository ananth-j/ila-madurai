import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../editpages/vehicle_edit.dart';
import '../inspect_list/vehicle_inspect.dart';
import '../logics/vehicle_logic.dart';

class VehicleList extends StatefulWidget {
  final snap;
  final id;
  const VehicleList({super.key, required this.snap, required this.id});

  @override
  State<VehicleList> createState() => _VehicleListState();
}

class _VehicleListState extends State<VehicleList> {
  // For timestap to date
  data(timestamp) {
    return DateFormat.yMMMd().format(timestamp.toDate());
  }

  VehicleLogic object = VehicleLogic();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => VehicleInspect(
                  snap: widget.snap,
                  id: widget.id,
                )));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Card(
           color : const  Color.fromARGB(255, 233, 232, 232),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 7, vertical: 5),
            height: 120,
            width: double.infinity,
            child: Row(
              //  mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name       : ${widget.snap['vehname']}',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                    ),
                    Spacer(),
                    Text(
                      'No             : ${widget.snap['vehnumber']}',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    Spacer(),
                    Text(
                      'Capacity  : ${widget.snap['capacity']}',
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    Spacer(),
                    Text(
                      'Last Service : ${data(widget.snap['serviceddate'])}',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    Spacer(),
                    Text(
                      'Next Service : ${data(widget.snap['nextservice'])}',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const Spacer(),
                PopupMenuButton(
                  splashRadius: 17,
                  itemBuilder: (context) => [
                    const PopupMenuItem(child: Text('edit'), value: 1),
                    const PopupMenuItem(child: Text('delete'), value: 2),
                  ],
                  onSelected: (value) {
                    if (value == 1) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => VehicleEditFrom(
                                id: widget.id,
                                snap: widget.snap,
                              ))));
                    } else if (value == 2) {
                      object.deleteVehicle(widget.id);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
