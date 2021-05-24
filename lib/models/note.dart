class Note {
  final int id;
  final String title;
  final String? content;
  final DateTime createTime;
  final DateTime modifyTime;

  Note(this.id, this.title, this.content, this.createTime, this.modifyTime);

  @override
  String toString() {
    return 'Note{id: $id, title: $title, content: $content, createTime: $createTime, modifyTime: $modifyTime}';
  }
}
