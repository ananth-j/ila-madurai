import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

import '../db/mongodb.dart';
import '../forms/customer_form.dart';
import '../lists/customer_list.dart';
import '../res/colors.dart';

class CustomersPage extends StatefulWidget {
  const CustomersPage({super.key});

  @override
  State<CustomersPage> createState() => _CustomersPageState();
}

class _CustomersPageState extends State<CustomersPage> {
  var maindata;
  static Future<List<Map<String, dynamic>>> getcustomers() async {
    var data = Connector.getcustomers();
    print(data.toString());
    return data;
  }

  @override
  void initState() {
    maindata = getcustomers();

    //Xdata();
    super.initState();
  }

  String name = '';
  int popvalue = 0;

  TextStyle appbarStyle = const TextStyle(
      color: Color.fromARGB(255, 255, 255, 255),
      fontSize: 19,
      fontWeight: FontWeight.w500);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
                  Text('Customers', style: appbarStyle),
                  const Spacer(),
                  // Search feild
                  SizedBox(
                    width: 130,
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
                            builder: (context) => CustomerForm()));
                      },
                      icon: Icon(Icons.person_add_alt_1)),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: FutureBuilder(
                  future: maindata, //getcustomers(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                          child: CircularProgressIndicator(
                        color: Color.fromARGB(255, 243, 177, 33),
                      ));
                    }

                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (ctx, index) {
                            var data = snapshot.data[index];

                            if (name.isEmpty) {
                              return CustomerList(
                                id: data['_id'],
                                snap: data,
                              );
                            }
                            if (data
                                .toString()
                                .toLowerCase()
                                .contains(name.toLowerCase())) {
                              return CustomerList(
                                id: data['_id'],
                                snap: data,
                              );
                            }
                            return Container();
                          });
                    }
                    return Container();
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
