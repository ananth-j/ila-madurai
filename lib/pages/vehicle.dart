import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ila/forms/vehicle_form.dart';

import '../lists/vehicle_list.dart';
import '../res/colors.dart';
import '../widgets/inside_custom_appbar.dart';

class VehicleScreen extends StatefulWidget {
  const VehicleScreen({super.key});

  @override
  State<VehicleScreen> createState() => _VehicleScreenState();
}

class _VehicleScreenState extends State<VehicleScreen> {
  String name = '';
  TextStyle appbarStyle = const TextStyle(
      color: Color.fromARGB(255, 255, 255, 255),
      fontSize: 19,
      fontWeight: FontWeight.w500);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                color: appBarbg,
              ),
              child: Row(
                children: [
                  IconButton(
                      splashRadius: 20,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.arrow_back)),
                  const Spacer(),
                  Text(
                    'Vehicles',
                    style: appbarStyle,
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 150,
                    height: 50,
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          name = value;
                        });
                      },
                      decoration: InputDecoration(
                        fillColor: Color.fromARGB(255, 255, 255, 255),
                        filled: true,
                        suffixIcon: Icon(Icons.search),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide(width: 1.5)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide(width: 1.5)),
                        hintText: 'search',
                      ),
                    ),
                  ),
                  IconButton(
                      splashRadius: 20,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => VehicleForm()));
                      },
                      icon: Icon(Icons.fire_truck_outlined)),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('vehicles')
                    .snapshots(includeMetadataChanges: false),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (ctx, index) {
                          var data = snapshot.data!.docs[index]
                              .data()
                              .toString()
                              .toLowerCase();
                          if (name.isEmpty) {
                            return VehicleList(
                              id: snapshot.data!.docs[index].id,
                              snap: snapshot.data!.docs[index],
                            );
                          }
                          try {
                            if (data.contains(name.toLowerCase())) {
                              return VehicleList(
                                id: snapshot.data!.docs[index].id,
                                snap: snapshot.data!.docs[index],
                              );
                            }
                          } catch (e) {}
                         
                          return Container();
                        }),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
