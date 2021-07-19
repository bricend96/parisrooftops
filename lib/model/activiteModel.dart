class Activities {
  String? id;
  String? nom;
  String? description;
  String? photo;
  


 Activities(
      {required this.id,
      required this.nom,
      required this.description,
      required this.photo
     });

 Activities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nom   = json['nom'];
    description = json['description'];
    photo = json['photo'];
   

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nom'] = this.nom;
    data['description'] = this.description;
    data['photo'] = this.photo;

    return data;
  }
}
