// ignore_for_file: public_member_api_docs, sort_constructors_first, depend_on_referenced_packages
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../shared_ui/themes/colors.dart';
import '../../shared_ui/themes/text_styles.dart';

const List<String> list = <String>[
  'Nữ miền Bắc (Liên)',
  'Nam miền Bắc (Hải)',
  'Nữ miền Trung (Hồng)',
  'Nam miền Nam (Đăng)'
];

class SpeechToTextPage extends StatefulWidget {
  const SpeechToTextPage({super.key});

  @override
  State<SpeechToTextPage> createState() => _SpeechToTextPageState();
}

class _SpeechToTextPageState extends State<SpeechToTextPage> {
  //set drop down menu show the first item
  String dropdownValue = list.first;

  bool activeAnimation = false;

  String speechValue =
      "Đại dịch Covid-19 càn quét lần thứ 4 trong nhiều tháng qua không chỉ gây những thiệt hại nặng nề về kinh tế - xã hội mà còn khiến nhiều gia đình không may gặp phải hoàn cảnh hết sức khó khăn. Đặc biệt, nhiều em nhỏ còn đang tuổi ăn học đã mất đi gia đình, người thân, thậm chí nhiều em đã không may mồ côi cả cha lẫn mẹ. Thấu hiểu và sẻ chia với hoàn cảnh của các em, mới đây, Công ty Xổ số Điện toán Việt Nam (Vietlott) khởi động giải chạy ảo với chủ đề “Chạy gắn kết, Tết yêu thương” nhằm chung tay cùng quỹ Hope (thuộc báo điện tử Vnexpress) trao tặng quà cho trẻ em mồ côi do tác động của đại dịch.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chuyển giọng nói thành văn bản',
          style: tStyle.display18().w500().copyWith(
                color: Hcm23Colors.colorTextTitle,
              ),
        ),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //record button
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(
                    20,
                    (index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 1),
                          child: AnimatedSound(
                            activeAnimation: activeAnimation,
                            key: UniqueKey(),
                          ),
                        )),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        activeAnimation = !activeAnimation;
                      });
                    },
                    onTapCancel: () {},
                    child: Ink(
                      height: 100,
                      width: 100,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(50.0),
                        ),
                        color: Hcm23Colors.color3.withOpacity(0.1),
                      ),
                      child: SvgPicture.asset(
                        "assets/icons/voice2.svg",
                        fit: BoxFit.fill,
                        color: Hcm23Colors.color3,
                      ),
                    ),
                  ),
                ),
                ...List.generate(
                    20,
                    (index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0.5),
                          child: AnimatedSound(
                            activeAnimation: activeAnimation,
                            key: UniqueKey(),
                          ),
                        )),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Tap vào icon để thu âm giọng nói",
              style: tStyle.display16().w400().copyWith(
                    color: Hcm23Colors.colorTextContent,
                  ),
            ),
            const SizedBox(
              height: 20,
            ),
            //show the text
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(8.0),
                ),
                border: Border.all(
                  width: 1,
                  color: Hcm23Colors.colorStroke,
                ),
              ),
              child: Align(
                  alignment: Alignment.center,
                  child: RichText(
                    text: TextSpan(
                      text: speechValue,
                      // maxLines: 10,
                      // textAlign: TextAlign.justify,
                      style: tStyle
                          .display16()
                          .w400()
                          .copyWith(color: Hcm23Colors.colorTextContent),
                    ),
                  )),
            ),
            // Hcm23BaseInput(
            //   baseConfigs: BaseInputConfigs(
            //     decoration: const InputDecoration(),
            //     feedBackType: FeedbackType.none,
            //   ),
            // ),
            //drop down button and read button
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(4.0),
                ),
                border: Border.all(
                  color: Hcm23Colors.colorStroke,
                ),
              ),
              child: DropdownButton<String>(
                isExpanded: true,
                value: dropdownValue,
                icon: SvgPicture.asset(
                  "assets/icons/chevron.svg",
                  color: Hcm23Colors.colorStroke,
                ),
                elevation: 16,
                style: tStyle
                    .display14()
                    .w400()
                    .copyWith(color: Hcm23Colors.colorTextTitle),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    dropdownValue = value!;
                  });
                },
                items: list.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            //read button
            InkWell(
              onTap: () {},
              child: Ink(
                color: Hcm23Colors.color3,
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                  ),
                  width: double.infinity,
                  height: 48,
                  child: Center(
                    child: Text("Đọc ngay",
                        style: tStyle.display14().w500().copyWith(
                              color: Hcm23Colors.colorWhite,
                            )),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AnimatedSound extends StatefulWidget {
  final bool activeAnimation;
  const AnimatedSound({
    Key? key,
    required this.activeAnimation,
  }) : super(key: key);

  @override
  State<AnimatedSound> createState() => _AnimatedSoundState();
}

class _AnimatedSoundState extends State<AnimatedSound> {
  bool state = false;
  @override
  void initState() {
    super.initState();
    if (widget.activeAnimation) {
      updateState();
    }
  }

  @override
  void didUpdateWidget(AnimatedSound oldWidget) {
    if (widget.activeAnimation) {
      updateState();
    }
    super.didUpdateWidget(oldWidget);
  }

  updateState() async {
    setState(() {
      state = !state;
    });
    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      updateState();
    }
  }

  final double randomHeight = Random().nextDouble() * 50;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: state ? randomHeight : 2,
      width: state ? 2 : 2,
      color: Hcm23Colors.color2,
      duration: const Duration(
        milliseconds: 300,
      ),
    );
  }
}
