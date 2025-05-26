import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../forms/employee_form.dart';
import '../lists/employee_list.dart';
import '../res/colors.dart';

class EmploysScreen extends StatefulWidget {
  const EmploysScreen({super.key});

  @override
  State<EmploysScreen> createState() => _EmploysScreenState();
}

class _EmploysScreenState extends State<EmploysScreen> {
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
                    'Employes',
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
                        fillColor: Colors.white,
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
                            builder: (context) => EmployeeForm()));
                      },
                      icon: Icon(Icons.person_add_alt_sharp)),
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
                    .collection('employees')
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
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (ctx, index) {
                          var data =
                              snapshot.data!.docs[index].data().toString().toLowerCase();
                          if (name.isEmpty) {
                            return EmployeeList(
                              id: snapshot.data!.docs[index].id,
                              snap: snapshot.data!.docs[index],
                            );
                          }
                          if (data.contains(name.toLowerCase())) {
                            return EmployeeList(
                              id: snapshot.data!.docs[index].id,
                              snap: snapshot.data!.docs[index],
                            );
                          }
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
