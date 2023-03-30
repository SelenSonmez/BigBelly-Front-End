import 'package:dropdown_button2/dropdown_button2.dart';

import '../../imports.dart';

const List<String> list = <String>[
  'Patates',
  'Domates',
  'Salatalık',
  'Un',
];

class BigBellyDropdown extends StatefulWidget {
  BigBellyDropdown({super.key});

  @override
  State<BigBellyDropdown> createState() => _BigBellyDropdownState();
}

final TextEditingController textEditingController = TextEditingController();

class _BigBellyDropdownState extends State<BigBellyDropdown> {
  String dropdownValue = list.first;
  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            alignment: Alignment.center,
            isExpanded: true,
            hint: Text(
              'Select Ingredient',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).hintColor,
              ),
            ),
            items: list
                .map((item) => DropdownMenuItem(
                      alignment: Alignment.center,
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ))
                .toList(),
            value: selectedValue,
            onChanged: (value) {
              setState(() {
                selectedValue = value! as String;
              });
            },
            buttonStyleData: ButtonStyleData(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: Color.fromARGB(201, 226, 223, 223)),
              height: 40,
              width: 150,
            ),
            dropdownStyleData: DropdownStyleData(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Color.fromARGB(202, 255, 251, 251),
              ),
              maxHeight: 250,
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 40,
            ),
            dropdownSearchData: DropdownSearchData(
              searchController: textEditingController,
              searchInnerWidgetHeight: 50,
              searchInnerWidget: Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
                child: TextFormField(
                  expands: true,
                  maxLines: null,
                  controller: textEditingController,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    hintText: 'Search for an item...',
                    hintStyle: const TextStyle(fontSize: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              searchMatchFn: (item, searchValue) {
                return (item.value
                    .toString()
                    .toLowerCase()
                    .contains(searchValue.toLowerCase()));
              },
            ),
            //This to clear the search value when you close the menu
            onMenuStateChange: (isOpen) {
              if (!isOpen) {
                textEditingController.clear();
              }
            },
          ),
        ),
      ],
    );
  }
}
