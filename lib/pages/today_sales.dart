import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../lists/sales_vehicle_list.dart';

class TodaySales extends StatefulWidget {
  const TodaySales({super.key});

  @override
  State<TodaySales> createState() => _TodaySalesState();
}

class _TodaySalesState extends State<TodaySales> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Vehicle'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 15),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('vehicles')
                    .snapshots(includeMetadataChanges: false),
                builder: ((context,
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
                        itemBuilder: (context, index) {
                          var data = snapshot.data!.docs[index];
                          var id = snapshot.data!.docs[index].id;

                          return SalesVehicleList(data: data, id: id);
                        }),
                  );
                })),
          ],
        ),
      ),
    );
  }
}
