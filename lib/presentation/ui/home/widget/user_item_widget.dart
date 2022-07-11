import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:navolaya_flutter/core/route_generator.dart';

import '../../../../core/color_constants.dart';

class UserItemWidget extends StatelessWidget {
  final String image;

  const UserItemWidget({required this.image, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(RouteGenerator.userDetailPage, arguments: image);
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6.0),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                image,
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  color: Colors.black45.withOpacity(0.5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Jordan Poole',
                        style: TextStyle(
                            color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),

                      const Text(
                        'ADR University',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: const [
                          Icon(
                            FontAwesomeIcons.shirt,
                            color: ColorConstants.appColor,
                            size: 10,
                          ),
                          SizedBox(width: 4,),
                          Text(
                            'Navolaya',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 10,
                          ),
                          SizedBox(width: 2,),
                          Text(
                            'Male',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.share,
                            color: Colors.white,
                            size: 10,

                          ),
                          SizedBox(width: 2,),
                          Text(
                            'Yes',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      OutlinedButton(
                        onPressed: null,
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size.fromHeight(30),
                          shape: RoundedRectangleBorder(

                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          side: const BorderSide(width: 1.0, color: Colors.white),
                        ),
                        child: const Text(
                          "Connect",
                          style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
