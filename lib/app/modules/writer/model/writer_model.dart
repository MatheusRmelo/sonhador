class WriterModel {
  final String id;
  String title;
  final List pages;
  String alignment;

  WriterModel({this.id, this.title, this.pages, this.alignment});

  void editPage(String page, int index) {
    this.pages[index] = page;
  }

  void cleanUpPages() {
    this.pages.remove('');
  }

  void addPage() {
    this.pages.add('');
  }
}
