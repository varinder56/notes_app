import 'package:flutter/material.dart';
import 'package:notes_var/sun.dart';

class NoteDetailPage extends StatefulWidget {
  final NoteMode mode;
  final ANote? note;
  const NoteDetailPage({super.key, required this.mode, this.note});
  @override
  State<NoteDetailPage> createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  late NoteMode _mode;

  @override
  void initState() {
    super.initState();
    _mode = widget.mode;
    if (widget.note != null) {
      titleController.text = widget.note!.title;
      contentController.text = widget.note!.content;
    }
  }

  var titleController = TextEditingController();
  var contentController = TextEditingController();
  final FocusNode _contentFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    bool isReadOnly = _mode == NoteMode.view;
    return Scaffold(
      appBar: AppBar(
        title: Text("Note"),
        actions: _mode == NoteMode.view
            ? [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    setState(() {
                      _mode = NoteMode.edit;
                      _contentFocusNode.requestFocus();
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    final confirm = await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(widget.note!.title),
                          content: Text(
                            "This note will be permanently deleted.",
                          ),
                          actions: [
                            TextButton.icon(
                              onPressed: () {
                                Navigator.pop(context, false);
                              },
                              label: Text("Cancel"),
                              icon: Icon(Icons.cancel_outlined),
                            ),
                            TextButton.icon(
                              onPressed: () {
                                Navigator.pop(context, true);
                              },
                              label: Text("Delete"),
                              icon: Icon(
                                Icons.delete_outline,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        );
                      },
                    );
                    if (confirm == true) {
                      Navigator.pop(context, NoteAction.deleted);
                    }
                  },
                ),
              ]
            : null,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: TextField(
              controller: titleController,
              readOnly: isReadOnly,
              decoration: InputDecoration(
                hintText: "Title",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: contentController,
                focusNode: _contentFocusNode,
                readOnly: isReadOnly,
                decoration: InputDecoration(
                  hintText: "Start typing your note here...",
                  border: InputBorder.none,
                ),
                maxLines: null,
                textAlignVertical: TextAlignVertical.center,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: _mode != NoteMode.view
          ? FloatingActionButton(
              backgroundColor: Colors.blueGrey[100],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              onPressed: () {
                if (contentController.text.trim().isEmpty) {
                  Navigator.pop(context);
                  return;
                }
                final currentNote = createNote(
                  title: titleController.text,
                  content: contentController.text,
                );
                Navigator.pop(context, currentNote);
              },
              child: Icon(Icons.check_outlined, size: 25),
            )
          : null,
    );
  }
}
