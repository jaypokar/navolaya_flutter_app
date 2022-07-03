import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:navolaya_flutter/core/color_constants.dart';
import 'package:navolaya_flutter/presentation/ui/user/widget/user_qualification_item_widget.dart';

class UserPersonalAndEducationWidget extends StatelessWidget {
  const UserPersonalAndEducationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> q1 = ['ABC School', 'Student', '2010 - 2014'];
    final List<String> q2 = ['Shivalik', 'Engineering', 'Software Engineer'];
    final List<String> q3 = ['03 Nov 1992', 'Male', '8160231082'];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 5,
          ),
          const Text(
            'Stephan Curry',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 20,
            child: ListView.builder(
              itemBuilder: (context, i) {
                late IconData iconData;
                if (i == 0) {
                  iconData = FontAwesomeIcons.bookBookmark;
                } else if (i == 1) {
                  iconData = FontAwesomeIcons.chain;
                } else {
                  iconData = FontAwesomeIcons.calendar;
                }
                return UserQualificationItemWidget(title: q1[i], iconData: iconData);
              },
              itemCount: q1.length,
              physics: const ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 20,
            child: ListView.builder(
              itemBuilder: (context, i) {
                late IconData iconData;
                if (i == 0) {
                  iconData = FontAwesomeIcons.shirt;
                } else if (i == 1) {
                  iconData = FontAwesomeIcons.school;
                } else {
                  iconData = FontAwesomeIcons.computer;
                }
                return UserQualificationItemWidget(title: q2[i], iconData: iconData);
              },
              itemCount: q1.length,
              physics: const ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 20,
            child: ListView.builder(
              itemBuilder: (context, i) {
                late IconData iconData;
                if (i == 0) {
                  iconData = FontAwesomeIcons.cakeCandles;
                } else if (i == 1) {
                  iconData = FontAwesomeIcons.user;
                } else {
                  iconData = FontAwesomeIcons.phone;
                }
                return UserQualificationItemWidget(title: q3[i], iconData: iconData);
              },
              itemCount: q1.length,
              physics: const ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    side: const BorderSide(width: 1.0, color: ColorConstants.appColor),
                  ),
                  child: const Text(
                    "CONNECT",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    side: const BorderSide(width: 1.0, color: ColorConstants.appColor),
                  ),
                  child: const Text(
                    "MESSAGES",
                    style: TextStyle(color: ColorConstants.appColor, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(width: 10,),
              Container(
                padding: const EdgeInsets.all(5),
                  decoration:  BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.more_horiz)),
            ],
          ),

        ],
      ),
    );
  }
}
