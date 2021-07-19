class Places {
  String? id;
  String? photo;
  String? nom;
  String? description;
  String? evenement;
  String? lieu;
  String? contact;
    String? categorie;


 Places(
      {required this.id,
      required this.photo,
      required this.nom,
      required this.description,
      required this.evenement,
      required this.lieu,
      required this.contact,
      required this.categorie});

 Places.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    photo = json['photo'];
    nom = json['nom'];
    description = json['description'];
    evenement = json['evenement'];
    lieu = json['lieu'];
    contact = json['contact'];
        categorie = json['categorie'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['photo'] = this.photo;
    data['nom'] = this.nom;
    data['description'] = this.description;
    data['evenement'] = this.evenement;
    data['lieu'] = this.lieu;
    data['contact'] = this.contact;
        data['categorie'] = this.categorie;

    return data;
  }
}
