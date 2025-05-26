import 'package:flutter/material.dart';
import 'package:ila/pages/today_sales.dart';
import 'package:ila/pages/vehicle.dart';

import 'customers.dart';
import 'employs.dart';
import 'filter.dart';

class SubHome extends StatefulWidget {
  const SubHome({super.key});

  @override
  State<SubHome> createState() => _SubHomeState();
}

class _SubHomeState extends State<SubHome> {
  @override
  Widget build(BuildContext context) {
    final titleStyle = TextStyle(fontSize: 15, fontWeight: FontWeight.w600);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        //  crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Card(
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const TodaySales()));
              },
              child: Container(
                  color: Colors.grey.shade200,
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: double.infinity,
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 50,
                      ),
                      Text(
                        'Sales',
                        style: titleStyle,
                      ),
                      const Spacer(flex: 1),
                      const Icon(
                        Icons.shopping_cart,
                        size: 30,
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                    ],
                  )),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => const FilterScreen())));
            },
            child: Card(
              child: Container(
                  color: Colors.grey.shade200,
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: double.infinity,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 50,
                      ),
                      Text(
                        'Sales Report',
                        style: titleStyle,
                      ),
                      Spacer(flex: 1),
                      Icon(
                        Icons.note,
                        size: 30,
                      ),
                      SizedBox(
                        width: 50,
                      ),
                    ],
                  )),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CustomersPage()));
            },
            child: Card(
              child: Container(
                  color: Colors.grey.shade200,
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: double.infinity,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 50,
                      ),
                      Text(
                        'Customers',
                        style: titleStyle,
                      ),
                      Spacer(flex: 1),
                      Icon(
                        Icons.person,
                        size: 30,
                      ),
                      SizedBox(
                        width: 50,
                      ),
                    ],
                  )),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const EmploysScreen()));
            },
            child: Card(
              child: Container(
                  color: Colors.grey.shade200,
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: double.infinity,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 50,
                      ),
                      Text(
                        'Employees',
                        style: titleStyle,
                      ),
                      Spacer(flex: 1),
                      Icon(
                        Icons.people,
                        size: 30,
                      ),
                      SizedBox(
                        width: 50,
                      ),
                    ],
                  )),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => VehicleScreen()));
            },
            child: Card(
              child: Container(
                  color: Colors.grey.shade200,
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: double.infinity,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 50,
                      ),
                      Text(
                        'Vehicle',
                        style: titleStyle,
                      ),
                      Spacer(),
                      Icon(Icons.airport_shuttle_sharp, size: 30),
                      SizedBox(
                        width: 50,
                      ),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
