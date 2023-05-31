import 'package:flutter/cupertino.dart';

class Frame12145 extends StatelessWidget {
  const Frame12145({
    required this.message,
    super.key,
  });

  final String message;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 55, left: 49),
      padding: const EdgeInsets.only(top: 16, bottom: 16, right: 14, left: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color.fromARGB(255, 217, 243, 220),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
              fit: BoxFit.fitHeight,
              "assets/images/TickSquare.png",
              width: 20,
              height: 20),
          const SizedBox(width: 12),
          Text(
            message,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              // fontFamily: Roboto,
            ),
          )
        ],
      ),
    );
  }
}
