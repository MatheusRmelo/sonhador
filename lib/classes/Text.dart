class Text {
  String title, userId, hashtags, alignment;
  List pages;
  bool published, ads, adult;

  Text(String userId,
      [String title = 'Sem título',
      List pages,
      bool published = false,
      bool ads = true,
      bool adult = false,
      String hashtags = '',
      String alignment = 'left']) {
    this.userId = userId;
    this.title = title;
    this.pages = pages == null ? [''] : pages;
    this.published = published;
    this.ads = ads;
    this.adult = adult;
    this.hashtags = hashtags;
    this.alignment = alignment;
  }

  Map<String, dynamic> getText() {
    return {
      "title": this.title,
      "pages": this.pages,
      "published": this.published,
      "ads": this.ads,
      "adult": this.adult,
      "hashtags": this.hashtags,
      "alignment": this.alignment,
      "userId": this.userId
    };
  }

  /*-----------Título-----------*/
  void setTitle(String title) {
    this.title = title;
  }

  String getTitle() {
    return this.title;
  }

  /*-----------Páginas-----------*/
  void newPage() {
    this.pages.add('');
  }

  void cleanUpPages() {
    this.pages.remove('');
  }

  void setPage(String page, int index) {
    this.pages[index] = page;
  }

  void setPages(List pages) {
    this.pages = pages;
  }

  String getPage(int index) {
    return this.pages[index];
  }

  List getPages() {
    return this.pages;
  }

  /*-----------Publicação-----------*/
  bool getPublished() {
    return this.published;
  }

  /*-----------Hashtag-----------*/
  void setHashtags(String hashtags) {
    this.hashtags = hashtags;
  }

  String getHashtags() {
    return this.hashtags;
  }

  /*-----------Anúncio e contéudo se tem impróprio -----------*/
  void setAds(bool ads) {
    this.ads = ads;
  }

  bool getAds() {
    return this.ads;
  }

  bool getAdult() {
    return this.adult;
  }

  /*-----------Alinhamento-----------*/
  void setAlignment(String alignment) {
    this.alignment = alignment;
  }

  String getAlignment() {
    return this.alignment;
  }
}
