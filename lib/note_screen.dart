import 'package:flutter/material.dart';
import 'package:notes_var/sun.dart';

class NoteDetailPage extends StatefulWidget {
  const NoteDetailPage({super.key});
  @override
  State<NoteDetailPage> createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  var titleController = TextEditingController();
  var contentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Note")),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: TextField(
              controller: titleController,
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey[100],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        onPressed: () {
          if (contentController.text.trim().isEmpty) {
            Navigator.pop(context);
            return;
          }
          final newNote = createNote(
            title: titleController.text,
            content: contentController.text,
          );
          Navigator.pop(context, newNote);
        },
        child: Icon(Icons.check_outlined, size: 25),
      ),
    );
  }
}
