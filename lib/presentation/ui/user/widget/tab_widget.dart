import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/color_constants.dart';

class TabWidget extends StatelessWidget {
  final TabController controller;
  const TabWidget({required this.controller,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            offset: const Offset(0.0, -5.0), //(x,y)
            blurRadius: 5.0,
          ),
        ],
      ),
      child:  TabBar(
        labelColor: ColorConstants.appColor,
        unselectedLabelColor: Colors.grey,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorWeight: 3,
        indicatorColor: ColorConstants.appColor,
        onTap: (index){
          if(index == 2){
            return;
          }
          controller.index = index;
        },
        tabs: const[
          Tab(
            text: null,
            icon: Icon(
              FontAwesomeIcons.house,
              size: 25,
            ),
          ),
          Tab(
            text: null,
            icon: Icon(
              FontAwesomeIcons.peopleGroup,
              size: 25,
            ),
          ),
          IgnorePointer(
            child: Tab(
              text: '',
              icon: null,
            ),
          ),
          Tab(
            text: null,
            icon: Icon(
              FontAwesomeIcons.facebookMessenger,
              size: 25,
            ),
          ),
          Tab(
            text: null,
            icon: Icon(
              Icons.notifications,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
