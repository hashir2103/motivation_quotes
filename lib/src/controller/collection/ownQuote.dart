
class OwnQuote {
    OwnQuote({
        this.quote,
        this.author,
    });

    String quote;
    String author;

    factory OwnQuote.fromMap(Map<String, dynamic> json) => OwnQuote(
        quote: json["quote"],
        author: json["author"],
    );

    Map<String, dynamic> toMap() => {
        "quote": quote,
        "author": author,
    };
}