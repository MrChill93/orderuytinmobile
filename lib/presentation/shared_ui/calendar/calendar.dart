// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class Calendar extends StatelessWidget {
  const Calendar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375,
      height: 335,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        color: Colors.blue,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            color: Color.fromRGBO(219, 223, 239, 0.5),
            blurRadius: 1,
          ),
        ],
      ),

      // padding: const EdgeInsets.all(5),

      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      "${DateTime.now().day} tháng ${DateTime.now().month}, ${DateTime.now().year}"),
                  IconButton(
                    icon: const Icon(Icons.arrow_drop_up),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                // print(DateTime.now().day);
                // print(DateTime.now().month);
              },
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            dayOfWeek('T2'),
            dayOfWeek('T3'),
            dayOfWeek('T4'),
            dayOfWeek('T5'),
            dayOfWeek('T6'),
            dayOfWeek('T7'),
            dayOfWeek('CN'),
          ],
        ),
        // const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.all(5),
          child: GridView.count(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 7,
            // crossAxisSpacing: 1.0,
            // mainAxisSpacing: 1.0,
            children: List.generate(30, (index) {
              return CalendarTile(index: index);
            }),
          ),
        ),
      ]),
    );
  }
}

class CalendarTile extends StatefulWidget {
  final int index;
  const CalendarTile({required this.index, Key? key}) : super(key: key);

  @override
  _CalendarTileState createState() => _CalendarTileState();
}

class _CalendarTileState extends State<CalendarTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.index == DateTime.now().day
              ? Container(
                  height: 32,
                  width: 32,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(13)),
                    color: Color.fromARGB(121, 113, 47, 236),
                  ),
                  child: Center(
                    child: Text(
                      '${widget.index + 1}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              : Text(
                  '${widget.index + 1}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          const SizedBox(height: 5),
          Container(
            width: 4,
            height: 4,
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
          ),
        ]);
  }
}

Widget dayOfWeek(String text) {
  return Container(
    margin: const EdgeInsets.only(left: 18, right: 17),
    width: 18,
    height: 15,
    child: Text(
      text,
      // textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 13),
    ),
  );
}
