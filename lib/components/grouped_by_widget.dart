import 'package:flutter/material.dart';
import 'package:valorant_randomizer/components/custom_padding_widget.dart';

class GroupedByWidget extends StatelessWidget {
  final TextEditingController? controller;
  final List<DropdownMenuEntry<int?>> items;
  const GroupedByWidget({
    required this.items,
    this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const CustomPaddingWidget(
          child: Text("Agrupado por: "),
        ),
        CustomPaddingWidget(
          child: DropdownMenu<int?>(
            initialSelection: 1,
            enableSearch: false,
            enableFilter: false,
            controller: controller,
            dropdownMenuEntries: items,
          ),
        ),
      ],
    );
  }
}
