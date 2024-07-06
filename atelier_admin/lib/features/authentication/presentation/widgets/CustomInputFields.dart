import 'package:atelier_admin/constraints/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../constraints/fonts.dart';

class CustomInputFields extends StatefulWidget {
  const CustomInputFields({super.key});

  @override
  State<CustomInputFields> createState() => _CustomInputFieldsState();
}

class _CustomInputFieldsState extends State<CustomInputFields> {
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  final List<TextEditingController> _controllers = List.generate(6, (_) => TextEditingController());
  final List<bool> autoFocus = List.generate(6, (index) => false,);


  @override
  void dispose() {
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    autoFocus[0] = true;
    return Form(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(6, (index) {
          return Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              child: TextFormField(
                autofocus: autoFocus[index],
                controller: _controllers[index],
                focusNode: _focusNodes[index],
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                // style: TextStyle(fontSize: 24),
                style: AppTextStyles.bodyMain16(color: AppColors.black1),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: AppColors.black3,
                      width: 0.5,
                    ),
                  ),
                ),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(1),
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChanged: (value) {
                  if (value.length == 1) {
                    if (index < 5) {
                      _focusNodes[index].unfocus();
                      FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
                    } else {
                      _focusNodes[index].unfocus();
                    }
                  } else if (value.isEmpty && index > 0) {
                    FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
                  }
                },
              ),
            ),
          );
        }),
      ),
    );
  }
}
