import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:navolaya_flutter/data/model/masters_model.dart';
import 'package:navolaya_flutter/presentation/basicWidget/text_field_widget.dart';

import '../../resources/color_constants.dart';

class BottomSheetSearchWidget<T> extends StatefulWidget {
  final List<T> data;
  final T? selectedValue;
  final String hint;
  final Function onValueSelect;

  const BottomSheetSearchWidget(
      {required this.data,
      this.selectedValue,
      required this.hint,
      required this.onValueSelect,
      Key? key})
      : super(key: key);

  @override
  State<BottomSheetSearchWidget> createState() => _BottomSheetSearchWidgetState<T>();
}

class _BottomSheetSearchWidgetState<T> extends State<BottomSheetSearchWidget<T>> {
  final TextEditingController _searchTextController = TextEditingController();

  List<T> tempList = [];

  @override
  void initState() {
    super.initState();
    tempList = widget.data;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: TextFieldWidget(
            controller: _searchTextController,
            hint: widget.hint,
            onValueChanged: (String value) => initiateSearch(value),
            prefixIcon: const Icon(Icons.search, color: ColorConstants.textColor3),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: GroupedListView<T, String>(
            elements: tempList,
            groupBy: (element) {
              if (element is Qualifications) {
                return element.area!;
              } else if (element is Occupations) {
                return element.type!;
              }
              return (element as Schools).state!;
            },
            groupHeaderBuilder: (T element) => setSearchItems(element, false, isHeader: true),
            itemBuilder: (context, T element) => setSearchItems(
              element,
              true,
              isHeader: false,
            ),
            useStickyGroupSeparators: true,
            // optional
            floatingHeader: false,
            // optional
            order: GroupedListOrder.ASC, // optional
          ),
        ),
      ],
    );
  }

  Widget setSearchItems(
    T value,
    bool isWidgetEnabled, {
    bool isHeader = false,
  }) {
    late final String title;
    if (value is Qualifications) {
      title = isHeader ? value.area! : '${value.title} (${value.shortName!})';
    } else if (value is Occupations) {
      title = isHeader ? value.type! : value.title!;
    } else if (value is Schools) {
      title = isHeader ? value.state! : 'JNV ${value.city!}, ${value.district!}';
    }
    return getTextWidget(isWidgetEnabled, title, value);
  }

  Widget getTextWidget(bool isWidgetEnabled, String title, T? element) {
    late final Widget mainWidget;
    if (isWidgetEnabled) {
      mainWidget = InkWell(
        onTap: () => widget.onValueSelect(element!),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: const TextStyle(color: Colors.black),
              ),
            )),
      );
    } else {
      mainWidget = Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          color: Colors.grey.withOpacity(0.2),
          child: Text(
            title,
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ));
    }
    return mainWidget;
  }

  void initiateSearch(String query) {
    final tempQuery = query.toLowerCase();
    setState(() {
      tempList = widget.data.where((element) {
        String title = '';
        String shortName = '';
        String district = '';
        if (element is Qualifications) {
          title = element.title!.toLowerCase();
          shortName = element.shortName!.toLowerCase();
        } else if (element is Occupations) {
          title = element.title!.toLowerCase();
        } else if (element is Schools) {
          title = element.city!.toLowerCase();
          shortName = element.state!.toLowerCase();
          district = element.district!.toLowerCase();
          if (title.contains(tempQuery) ||
              district.contains(tempQuery) ||
              shortName.contains(tempQuery)) {
            return true;
          }
        }

        return title.contains(tempQuery) || shortName.contains(tempQuery);
      }).toList();
    });
  }
}
