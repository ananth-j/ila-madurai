import 'package:flutter/material.dart';

import '../res/colors.dart';

class SubCustomAppbar extends StatefulWidget {
  final String name;
  final Icon icon;
  final pagenew;

  const SubCustomAppbar(
      {super.key,
      required this.name,
      required this.icon,
      required this.pagenew});

  @override
  State<SubCustomAppbar> createState() => _SubCustomAppbarState();
}

class _SubCustomAppbarState extends State<SubCustomAppbar> {
  @override
  Widget build(BuildContext context) {
    TextStyle appbarStyle = const TextStyle(
        color: Color.fromARGB(255, 255, 255, 255),
        fontSize: 19,
        fontWeight: FontWeight.w500);
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
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
          Text(widget.name, style: appbarStyle),
          const Spacer(),
          SizedBox(
            width: 150,
            height: 50,
            child: TextField(
              onChanged: (value) {},
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
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => widget.pagenew));
              },
              icon: widget.icon),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}
