//////////////////////////////////////////////////////////////////////////////////////////
class ANote {
  final String title;
  final String content;
  final DateTime date;
  ANote({required this.title, required this.content, required this.date});
}

////////////////////////////////////////////////////////////////////////////////////////////
ANote createNote({
  required String title,
  required String content,
  required DateTime date,
}) {
  return ANote(title: title, content: content, date: date);
}

////////////////////////////////////////////////////////////////////////////////////////////
String previewText(String content) {
  final lines = content.split('\n');

  if (lines.length <= 2) {
    return content;
  }
  return '${lines[1]}\n${lines[2]}\n…';
}

/////////////////////////////////////////////////////////////////////////////////////////////
enum NoteMode { create, view, edit }

enum NoteAction { deleted }

/////////////////////////////////////////////////////////////////////////////////////////////
List<ANote> onboardingNotes() {
  return [
    ANote(
      title: "Welcome👋",
      content:
          "This app helps you write quickly and stay organized.\n\n"
          "Notes are simple: a title and content. Let’s get started.",
      date: DateTime.now(),
    ),
    ANote(
      title: "Create a Note ➕",
      content:
          "Tap the + button to create a new note.\n\n"
          "You can start typing right away — no setup needed.",
      date: DateTime.now(),
    ),
    ANote(
      title: "Edit & Save ✏️",
      content:
          "Open any note and tap the edit icon.\n\n"
          "Changes are saved when you tap the ✔ button.",
      date: DateTime.now(),
    ),
    ANote(
      title: "Smart Titles 🧠",
      content:
          "If you forget to add a title,\n"
          "the first line of your note is shown as the title — only for display.",
      date: DateTime.now(),
    ),
    ANote(
      title: " 🗑️",
      content:
          "You can edit or delete any note anytime.\n\n"
          "These guide notes can be removed once you’re comfortable.",
      date: DateTime.now(),
    ),
  ];
}
