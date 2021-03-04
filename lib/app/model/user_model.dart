class UserModel {
  final String userId;
  final String displayName;
  final String userName;
  final List followers;
  final List following;

  UserModel(
      {this.userId,
      this.displayName,
      this.userName,
      this.followers,
      this.following});
}
