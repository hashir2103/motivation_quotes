class OwnQuote {
  OwnQuote({
    this.quote,
    this.author,
    this.id,
  });

  String quote;
  String author;
  int id;

  factory OwnQuote.fromMap(Map<String, dynamic> json) => OwnQuote(
        quote: json["quote"],
        author: json["author"],
        id: json['id']
      );

  Map<String, dynamic> toMap() => {
        "quote": quote,
        "author": author,
        "id": id
      };
}
