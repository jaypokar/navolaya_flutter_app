import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/presentation/ui/dashBoard/widget/bottom_sheet_filter_widget.dart';

import '../../../cubit/nearByUsersCubit/near_by_users_cubit.dart';

class FloatingActionButtonWidget extends StatelessWidget {
  const FloatingActionButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Transform.translate(
          offset: const Offset(0.0, 25.0),
          child: GestureDetector(
            onTap: () {},
            child: const SizedBox(
              height: 80,
              width: 100,
              child: Text(''),
            ),
          ),
        ),
        Transform.translate(
          offset: const Offset(0.0, 20.0),
          child: SizedBox(
            height: 62,
            width: 62,
            child: FloatingActionButton(
              onPressed: () {
                callBottomSheet(context);
              },
              shape: const StadiumBorder(side: BorderSide(color: Colors.white, width: 4)),
              child: const Icon(
                Icons.search,
                color: Colors.white,
                size: 35,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void callBottomSheet(BuildContext context) {
    final filterData = context.read<NearByUsersCubit>().fetchCachedFilterData();
    showModalBottomSheet(
        constraints: BoxConstraints.loose(
            Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height * 0.65)),
        // <= this is set to 3/4 of screen size.
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        context: context,
        builder: (_) {
          return BottomSheetFilterWidget(
            filterData: filterData,
          );
        });
  }
}
