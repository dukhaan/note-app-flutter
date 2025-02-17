import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:note_app/database/note_database.dart';
import 'package:note_app/models/note.dart';
import 'package:note_app/widgets/note_form_widget.dart';

class AddEditNotePage extends StatefulWidget {
  const AddEditNotePage({super.key, this.note});
  final Note? note;

  @override
  State<AddEditNotePage> createState() => _AddEditNotePageState();
}

class _AddEditNotePageState extends State<AddEditNotePage> {
  late bool _isImportant = false;
  late int _number = 1;
  late String _title = '';
  late String _description = '';
  final _formKey = GlobalKey<FormState>();
  var _isUpdateForm = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isImportant = widget.note?.isImportant ?? false;
    _number = widget.note?.number ?? 0;
    _title = widget.note?.title ?? '';
    _description = widget.note?.description ?? '';
    _isUpdateForm = widget.note != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isUpdateForm ? 'Update Note' : 'Create Note'),
        actions: [
          _buildButtonSave(),
        ],
      ),
      body: Form(
        key: _formKey,
        child: NoteFormWidget(
            isImportant: _isImportant,
            number: _number,
            title: _title,
            description: _description,
            onChangeIsImportant: (value) {
              setState(() {
                _isImportant = value;
              });
            },
            onChangeNumber: (value) {
              setState(() {
                _number = value;
              });
            },
            onChangeTitle: (value) {
              setState(() {
                _title = value;
              });
            },
            onChangeDescription: (value) {
              setState(() {
                _description = value;
              });
            }),
      ),
    );
  }

  Widget _buildButtonSave() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        onPressed: () async {
          final isValid = _formKey.currentState?.validate() ?? false;
          if (isValid) {
            if (_isUpdateForm) {
              await _updateNote();
            } else {
              await _addNote();
            }
            Navigator.pop(context);
          }
        },
        child: Text('Save'),
      ),
    );
  }

  Future<void> _updateNote() async {
    final note = widget.note!.copy(
      isImportant: _isImportant,
      number: _number,
      title: _title,
      description: _description,
    );
    await NoteDatabase.instance.update(note);
  }

  Future<void> _addNote() async {
    final note = Note(
      id: widget.note?.id,
      isImportant: _isImportant,
      number: _number,
      title: _title,
      description: _description,
      createdTime: DateTime.now(),
    );
    await NoteDatabase.instance.create(note);
  }
}
