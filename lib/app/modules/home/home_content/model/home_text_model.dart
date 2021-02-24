class HomeTextModel {
  final String id;
  final String title;
  final List pages;
  final String alignment;
  final List likes;
  final List comments;
  final List hashtags;
  final String userName;

  HomeTextModel(
      {this.id,
      this.title,
      this.pages,
      this.alignment,
      this.likes,
      this.comments,
      this.hashtags,
      this.userName});
}
