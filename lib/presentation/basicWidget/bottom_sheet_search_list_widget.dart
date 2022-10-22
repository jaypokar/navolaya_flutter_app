import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../data/model/masters_model.dart';
import '../../resources/color_constants.dart';

class BottomSheetSearchListWidget<T> extends StatefulWidget {
  final List<T> data;
  final T? selectedValue;
  final String hint;
  final Function onValueSelect;

  const BottomSheetSearchListWidget({
    required this.data,
    this.selectedValue,
    required this.hint,
    required this.onValueSelect,
    Key? key,
  }) : super(key: key);

  @override
  State<BottomSheetSearchListWidget<T>> createState() => _BottomSheetSearchListWidgetState<T>();
}

class _BottomSheetSearchListWidgetState<T> extends State<BottomSheetSearchListWidget<T>> {
  final TextEditingController _searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            border: Border.all(color: ColorConstants.inputBorderColor, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          /*padding: const EdgeInsets.all(15),*/
          child: TypeAheadField<T>(
            textFieldConfiguration: TextFieldConfiguration(
              autofocus: true,
              controller: _searchTextController,
              style: const TextStyle(fontSize: 14),
              textAlign: TextAlign.start,
              onChanged: (_) {
                setState(() {});
              },
              onSubmitted: (_) {
                Navigator.of(context).pop();
              },
              decoration: InputDecoration(
                hintText: widget.hint,
                hintStyle: const TextStyle(
                  fontSize: 14,
                ),
                isDense: true,
                hoverColor: Colors.white,
                icon: const Padding(padding: EdgeInsets.only(left: 10), child: Icon(Icons.search)),
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding: const EdgeInsets.only(left: 0, right: 10, bottom: 15, top: 15),
              ),
            ),
            suggestionsCallback: (pattern) {
              final query = pattern.toLowerCase();
              return widget.data.where((element) {
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
                  district = element.state!.toLowerCase();
                  shortName = element.district!.toLowerCase();
                  if (title.contains(query) ||
                      shortName.contains(title) ||
                      district.contains(query)) {
                    return true;
                  }
                }

                return title.contains(query) || shortName.contains(query);
              }).toList();
            },
            suggestionsBoxDecoration: const SuggestionsBoxDecoration(
              color: Colors.white,
            ),
            itemBuilder: (context, suggestion) {
              return setSearchItems(suggestion);
            },
            transitionBuilder: (context, suggestionsBox, controller) {
              return suggestionsBox;
            },
            onSuggestionSelected: (suggestion) {
              if (suggestion is Qualifications) {
                //_searchTextController.text = suggestion.shortName!;
                if (suggestion.shortName == suggestion.title) {
                  return;
                }
              } else if (suggestion is Schools) {
                if (suggestion.city == suggestion.state) {
                  return;
                }
              } else if (suggestion is Occupations) {
                if (suggestion.title == suggestion.type) {
                  return;
                }
              }
              widget.onValueSelect(suggestion);
            },
            /*onSaved: (value) => this._selectedParty = value,*/
          ),
        ),
        const Spacer()
      ],
    );
  }

  Widget setSearchItems(T value) {
    late final String title;
    bool isWidgetEnabled = true;
    if (value is Qualifications) {
      isWidgetEnabled = !value.isSeparator!;
      if (isWidgetEnabled) {
        title = value.title == 'Qualification' ? '' : '${value.title} (${value.shortName!})';
      } else {
        title = value.shortName!;
      }
    } else if (value is Occupations) {
      isWidgetEnabled = !value.isSeparator!;
      title = value.title! == 'Occupation' ? '' : value.title!;
    } else if (value is Schools) {
      isWidgetEnabled = !value.isSeparator!;
      if (isWidgetEnabled) {
        title = value.city == 'School' ? '' : 'JNV ${value.city!}, ${value.district!}';
      } else {
        title = value.city!;
      }
    }
    return getTextWidget(isWidgetEnabled, title);
  }

  Widget getTextWidget(bool isWidgetEnabled, String title) {
    late final Widget widget;
    if (isWidgetEnabled) {
      widget = title.isEmpty
          ? const SizedBox.shrink()
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: const TextStyle(color: Colors.black),
                ),
              ));
    } else {
      widget = Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          color: Colors.grey.withOpacity(0.2),
          child: Text(
            title,
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ));
    }
    return widget;
  }
}
