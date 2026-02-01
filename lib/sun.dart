//////////////////////////////////////////////////////////////////////////////////////////
class ANote {
  final String title;
  final String content;
  final DateTime dateCreated = DateTime.now();
  ANote({required this.title, required this.content});
}

////////////////////////////////////////////////////////////////////////////////////////////
ANote createNote({required String title, required String content}) {
  List<String> lines = content.trim().split('\n');
  if (title.trim().isNotEmpty) {
    return ANote(title: title, content: content);
  } else {
    final resolvedTitle = lines.isNotEmpty ? lines[0] : 'Untitled';
    final resolvedContent = lines.length > 1 ? lines.sublist(1).join('\n') : '';
    return ANote(title: resolvedTitle, content: resolvedContent);
  }
}

////////////////////////////////////////////////////////////////////////////////////////////
String previewText(String content) {
  final lines = content.split('\n');

  if (lines.length <= 2) {
    return content; // show as-is
  }

  return '${lines[0]}\n${lines[1]}\n…';
}
