import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NoteFormWidget extends StatelessWidget {
  const NoteFormWidget(
      {super.key,
      required this.isImportant,
      required this.number,
      required this.title,
      required this.description,
      required this.onChangeIsImportant,
      required this.onChangeNumber,
      required this.onChangeTitle,
      required this.onChangeDescription});
  final bool isImportant;
  final int number;
  final String title;
  final String description;
  final ValueChanged<bool> onChangeIsImportant;
  final ValueChanged<int> onChangeNumber;
  final ValueChanged<String> onChangeTitle;
  final ValueChanged<String> onChangeDescription;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Switch(value: isImportant, onChanged: onChangeIsImportant),
                Expanded(
                    child: Slider(
                  value: number.toDouble(),
                  min: 0,
                  max: 5,
                  divisions: 5,
                  onChanged: (value) => onChangeNumber(value.toInt()),
                ))
              ],
            ),
            _buildTitleField(),
            SizedBox(
              height: 8,
            ),
            _buildDescriptionField(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleField() {
    return TextFormField(
      maxLines: 1,
      initialValue: title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
      onChanged: onChangeTitle,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'Title',
        hintStyle: TextStyle(color: Colors.grey),
      ),
      validator: (title) {
        return title != null && title.isEmpty
            ? 'The Title cannot be empty'
            : null;
      },
    );
  }

  Widget _buildDescriptionField() {
    return TextFormField(
      maxLines: null,
      initialValue: description,
      style: TextStyle(fontSize: 16),
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'Description',
        hintStyle: TextStyle(color: Colors.grey),
      ),
      onChanged: onChangeDescription,
      validator: (description) {
        return description != null && description.isEmpty
            ? 'The Description cannot be empty'
            : null;
      },
    );
  }

  Widget _buildNumberField() {
    return TextFormField(
      maxLines: 1,
      initialValue: number.toString(),
      keyboardType: TextInputType.number,
      style: TextStyle(fontSize: 16),
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'Number',
        hintStyle: TextStyle(color: Colors.grey),
      ),
      onChanged: (value) => onChangeNumber(int.parse(value)),
      validator: (number) {
        return number != null && number.isEmpty
            ? 'The Number cannot be empty'
            : null;
      },
    );
  }
}
