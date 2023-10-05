import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:intl/intl.dart';

class AdaptativeDatePicker extends StatelessWidget {
  final DateTime? selectedDate;
  final Function(DateTime)? onDateChanged;

  AdaptativeDatePicker({this.selectedDate, this.onDateChanged});

  _showDatePiker(BuildContext context) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(DateTime.now().year - 1),
            lastDate: DateTime.now())
        .then((value) => {
              if (value != null)
                {
                  onDateChanged!(value),
                }
            });
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Container(
            height: 180,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: DateTime.now(),
              minimumDate: DateTime(DateTime.now().year - 1),
              maximumDate: DateTime.now(),
              onDateTimeChanged: onDateChanged!,
            ),
          )
        : Container(
            height: 70,
            child: Row(
              children: <Widget>[
                Expanded(
                    child: onDateChanged == null
                        ? const Text(
                            'Nenhuma data selecionada!',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : Text(
                            'Data selecionada: ${DateFormat('dd/MM/y').format(selectedDate!)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                TextButton(
                  onPressed: () => _showDatePiker(context),
                  child: const Text(
                    'Selecionar data',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
