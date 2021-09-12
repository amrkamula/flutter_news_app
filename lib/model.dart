class Article{
  String?  author, title, description, urlToArticle,urlToImage,publishedAt,content;
  Map<String,dynamic> source;

  Article({required this.source,
    required this.content,
    required this.author,
    required this.title,
    required this.description,
    required this.urlToArticle,
    required this.urlToImage,
    required this.publishedAt,
  });

  factory Article.fromJson(Map<String,dynamic> json){
    return Article(source: json['source'],
        content: json['content'],
        author:json[' author'],
        title:json['title'] ,
        description: json['description'],
        urlToArticle: json['url'],
        urlToImage: json['urlToImage'],
        publishedAt: json['publishedAt']);
  }

}