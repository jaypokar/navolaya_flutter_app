import 'package:flutter/material.dart';
import 'package:navolaya_flutter/presentation/ui/dashBoard/widget/user_item_widget.dart';

class RecentUsersWidget extends StatelessWidget {
  const RecentUsersWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GridView.builder(
        itemCount: 8,
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (ctx, index) => UserItemWidget(
          key: UniqueKey(),
          image: 'assets/${index + 1}.jpg',
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 0,
          mainAxisSpacing: 2,
        ),
      ),
    );
  }
}
