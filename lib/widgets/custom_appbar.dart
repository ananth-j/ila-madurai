import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../res/colors.dart';
import '../sms/smsScreen.dart';

class CustomAppbar extends StatefulWidget {
  const CustomAppbar({super.key});

  @override
  State<CustomAppbar> createState() => _CustomAppbarState();
}

class _CustomAppbarState extends State<CustomAppbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
        color: appBarbg,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 40,
          ),
          Text(
            'ABC  DRINKING WATER',
            style: GoogleFonts.faunaOne(
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 20,
                fontWeight: FontWeight.w700),
          ),
          Spacer(),
          PopupMenuButton(
            splashRadius: 17,
            itemBuilder: (context) => [
              const PopupMenuItem(child: Text('User Controlls'), value: 1),
            ],
            onSelected: (value) {
              if (value == 1) {
              } else if (value == 2) {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (contex) => SmsScreen()));
              }
            },
          ),
        ],
      ),
    );
  }
}
