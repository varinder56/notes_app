import 'package:flutter/material.dart';
import 'package:notes_var/note_screen.dart';
import 'package:notes_var/sun.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ANote> notes = [];
  int navIndex = 0;
  @override
  void initState() {
    super.initState();
    _initializeNoteList();
  }

  ///////////////////
  Future _initializeNoteList() async {
    final prefs = await SharedPreferences.getInstance();
    final bool freshApp = prefs.getBool("fresh") ?? true;
    if (freshApp) {
      setState(() {
        notes = onboardingNotes();
      });
      await prefs.setBool("fresh", false);
    } else {}
  }

  /// /////////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Text(
                "Notes",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Expanded(
            child: navIndex == 0
                ? ListView.builder(
                    itemCount: notes.length,
                    itemExtent: 130,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          left: 20.0,
                          right: 20.0,
                          bottom: 20,
                        ),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          margin: EdgeInsets.all(0),
                          child: ListTile(
                            onTap: () async {
                              final updatedNote = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NoteDetailPage(
                                    mode: NoteMode.view,
                                    note: notes[index],
                                  ),
                                ),
                              );
                              if (updatedNote == NoteAction.deleted) {
                                setState(() {
                                  notes.removeAt(index);
                                });
                              } else if (updatedNote != null) {
                                setState(() {
                                  notes[index] = updatedNote;
                                });
                              }
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            tileColor: Color(0xFFE6E8EB),

                            title: Text(
                              notes[index].title.isNotEmpty
                                  ? notes[index].title
                                  : notes[index].content.split('\n').first,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Text(
                              previewText(notes[index].content),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: Text(
                              DateFormat(
                                'dd/MM/yyyy',
                              ).format(notes[index].dateCreated),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : GridView.builder(
                    padding: EdgeInsets.all(20),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      childAspectRatio: 1,
                    ),
                    itemCount: notes.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () async {
                          final updatedNote = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NoteDetailPage(
                                mode: NoteMode.view,
                                note: notes[index],
                              ),
                            ),
                          );
                          if (updatedNote == NoteAction.deleted) {
                            setState(() {
                              notes.removeAt(index);
                            });
                          } else if (updatedNote != null) {
                            setState(() {
                              notes[index] = updatedNote;
                            });
                          }
                        },
                        child: Card(
                          color: Color(0xFFE6E8EB),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          margin: EdgeInsets.all(0),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  notes[index].title.isNotEmpty
                                      ? notes[index].title
                                      : notes[index].content.split('\n').first,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 4),
                                Expanded(
                                  child: Text(
                                    previewText(notes[index].content),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    DateFormat(
                                      'dd/MM/yyyy',
                                    ).format(notes[index].dateCreated),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey[100],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        onPressed: () async {
          final newNote = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NoteDetailPage(mode: NoteMode.create),
            ),
          );
          if (newNote != null) {
            setState(() {
              notes.add(newNote);
            });
          }
        },
        child: FaIcon(FontAwesomeIcons.plus, size: 25),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: const Color(0xFF212121),
        unselectedItemColor: const Color(0xFF9E9E9E),

        currentIndex: navIndex,
        onTap: (index) {
          setState(() {
            navIndex = index;
          });
        },

        items: [
          BottomNavigationBarItem(
            label: "List ",
            icon: FaIcon(FontAwesomeIcons.list),
          ),
          BottomNavigationBarItem(
            label: " Grid",
            icon: FaIcon(FontAwesomeIcons.gripVertical),
          ),
        ],
      ),
    );
  }
}
