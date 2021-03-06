class HomeTextModel {
  final String id;
  final String title;
  final List pages;
  final String alignment;
  final List likes;
  final List comments;
  final List shared;
  final List hashtags;
  final String userId;
  final String photoUrl;

  HomeTextModel(
      {this.id,
      this.title,
      this.pages,
      this.alignment,
      this.likes,
      this.comments,
      this.shared,
      this.hashtags,
      this.userId,
      this.photoUrl});
}
