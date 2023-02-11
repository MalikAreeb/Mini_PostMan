import 'package:flutter/material.dart';

class DropdownInputField extends StatefulWidget {
  final String dropdownlabel;
  final List dropdownListItem;
  final Function onchanged;
  const DropdownInputField(
      {Key? key,
      required this.dropdownlabel,
      required this.dropdownListItem,
      required this.onchanged})
      : super(key: key);

  @override
  State<DropdownInputField> createState() => _DropdownInputFieldState();
}

class _DropdownInputFieldState extends State<DropdownInputField> {
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.grey, width: 1),
        color: Colors.white,
      ),
      width: MediaQuery.of(context).size.width,
      child: DropdownButtonHideUnderline(
          child: DropdownButton<String?>(
              icon: const Icon(Icons.keyboard_arrow_down_rounded),
              isExpanded: true,
              hint: Text(
                widget.dropdownlabel,
                style: TextStyle(fontSize: 13, color: Colors.grey),
              ),
              value: dropdownValue,
              items: widget.dropdownListItem
                  .map((e) => DropdownMenuItem<String>(
                        value: e,
                        child: Text("$e"),
                      ))
                  .toList(),
              onChanged: (onSelectValue) {
                widget.onchanged(onSelectValue);
                setState(() {
                  dropdownValue = onSelectValue;
                });
              })),
    );
  }
}

Widget buildCreatOrderHeadersForInputSection({required String label}) {
  return Text(
    label,
    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
  );
}

class SmallInputField extends StatefulWidget {
  final Function onTextChange;
  final String labelText;
  final TextInputType textInputType;
  final Function fieldValidator;
  final int maxlength;
  final Function? onfieldSubmitted;
  const SmallInputField(
      {Key? key,
      required this.onTextChange,
      required this.labelText,
      required this.textInputType,
      required this.fieldValidator,
      required this.maxlength,
      this.onfieldSubmitted})
      : super(key: key);

  @override
  State<SmallInputField> createState() => _SmallInputFieldState();
}

class _SmallInputFieldState extends State<SmallInputField> {
  final FocusNode _textFieldFocus = FocusNode();
  Color _color = Colors.white;

  @override
  void initState() {
    _textFieldFocus.addListener(() {
      if (_textFieldFocus.hasFocus) {
        setState(() {
          _color = Colors.white;
        });
      } else {
        setState(() {
          _color = Colors.white;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width > 400) ? 170 : 150,
      height: 100,
      child: TextFormField(
        maxLength: widget.maxlength,
        focusNode: _textFieldFocus,
        keyboardType: widget.textInputType,
        onFieldSubmitted: (value) => widget.onfieldSubmitted!(value),
        validator: (value) => widget.fieldValidator(value),
        onChanged: (value) => widget.onTextChange(value),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
            counterText: "",
            hintText: widget.labelText,
            filled: true,
            fillColor: _color,
            hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
            focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black)),
            errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red)),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black))),
      ),
    );
  }
}
