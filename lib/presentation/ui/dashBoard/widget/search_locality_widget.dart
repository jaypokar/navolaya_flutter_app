import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_place/google_place.dart';
import 'package:navolaya_flutter/presentation/cubit/nearByUsersCubit/near_by_users_cubit.dart';
import 'package:navolaya_flutter/resources/string_resources.dart';

import '../../../../resources/color_constants.dart';
import '../../../cubit/keyboardVisibilityCubit/key_board_visibility_cubit.dart';

class SearchLocalityWidget extends StatefulWidget {
  final Function onValueSelect;
  final String searchedValue;

  const SearchLocalityWidget({required this.searchedValue, required this.onValueSelect, Key? key})
      : super(key: key);

  @override
  State<SearchLocalityWidget> createState() => _SearchLocalityWidgetState();
}

class _SearchLocalityWidgetState extends State<SearchLocalityWidget> {
  late final GooglePlace _googlePlace;
  List<AutocompletePrediction> predictions = [];
  final _searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchTextController.text = widget.searchedValue;
    _googlePlace = context.read<NearByUsersCubit>().getGooglePlace();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KeyBoardVisibilityCubit, bool>(
      builder: (_, isOpen) {
        return Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + (isOpen ? 100 : 0),
              left: 10,
              right: 10,
              top: 10),
          child: TypeAheadField<AutocompletePrediction>(
            textFieldConfiguration: TextFieldConfiguration(
              autofocus: false,
              controller: _searchTextController,
              style: const TextStyle(fontSize: 14),
              textAlign: TextAlign.start,
              onChanged: (_) {
                setState(() {});
              },
              onSubmitted: (_) {
                /*Navigator.of(context).pop();*/
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(width: 1),
                  ),
                  labelText: StringResources.searchByLocalityAddress,
                  counterText: "",
                  labelStyle: const TextStyle(color: ColorConstants.textColor3),
                  isDense: true,
                  alignLabelWithHint: true,
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    color: ColorConstants.inputBorderColor,
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorConstants.inputBorderColor,
                    ),
                  ),
                  disabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorConstants.inputBorderColor,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10)),
            ),
            suggestionsCallback: (pattern) async {
              if (pattern.isNotEmpty) {
                var result = await _googlePlace.autocomplete.get(pattern);
                if (result != null) {
                  setState(() {
                    predictions = result.predictions!;
                  });
                }
              }
              return predictions;
            },
            suggestionsBoxDecoration: const SuggestionsBoxDecoration(
              color: Colors.white,
            ),
            itemBuilder: (context, suggestion) {
              return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      suggestion.description!,
                      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                    ),
                  ));
            },
            transitionBuilder: (context, suggestionsBox, controller) {
              return suggestionsBox;
            },
            onSuggestionSelected: (suggestion) {
              _searchTextController.text = suggestion.description!;
              widget.onValueSelect(suggestion);
            },
            /*onSaved: (value) => this._selectedParty = value,*/
          ),
        );
      },
    );
  }
}
