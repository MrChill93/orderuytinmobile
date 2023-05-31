import 'package:flutter/material.dart';

class Frame12146 extends StatelessWidget {
  const Frame12146({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color.fromARGB(255, 217, 166, 233))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Bạn có chắc chắn muốn thoát ra không?",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              )),
          const SizedBox(height: 24),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              padding: const EdgeInsets.only(
                  top: 12, bottom: 12, right: 20, left: 20),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 229, 218, 245),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text("Không",
                  style: TextStyle(color: Color.fromARGB(255, 80, 31, 172))),
            ),
            const SizedBox(width: 16),
            Container(
              padding: const EdgeInsets.only(
                  top: 12, bottom: 12, right: 20, left: 20),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 112, 44, 214),
                borderRadius: BorderRadius.circular(4),
              ),
              child:
                  const Text("Đồng ý", style: TextStyle(color: Colors.white)),
            ),
          ])
        ],
      ),
    );
  }
}
