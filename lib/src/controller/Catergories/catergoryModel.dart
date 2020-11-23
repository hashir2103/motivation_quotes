class CatergoryModel {
    CatergoryModel({
        this.catergoryName,
        this.showCatergory,
    });

    String catergoryName;
    int showCatergory;

    factory CatergoryModel.fromMap(Map<String, dynamic> json) => CatergoryModel(
        catergoryName: json["catName"],
        showCatergory: json['showCat']
    );

    Map<String, dynamic> toMap() => {
        "catName": catergoryName,
        "showCat": showCatergory,
    };
}

