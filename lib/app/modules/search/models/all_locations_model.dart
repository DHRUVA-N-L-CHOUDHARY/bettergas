class AllLocationsModel {
    int? termId;
    String? name;
    String? slug;
    int? termGroup;
    int? termTaxonomyId;
    String? taxonomy;
    String? description;
    int? parent;
    int? count;
    String? filter;
    String? image;
    String? phone;
    String? address;
    String? termLink;

    AllLocationsModel({this.termId, this.name, this.slug, this.termGroup, this.termTaxonomyId, this.taxonomy, this.description, this.parent, this.count, this.filter, this.image, this.phone, this.address, this.termLink});

    AllLocationsModel.fromJson(Map<String, dynamic> json) {
        termId = json["term_id"];
        name = json["name"];
        slug = json["slug"];
        termGroup = json["term_group"];
        termTaxonomyId = json["term_taxonomy_id"];
        taxonomy = json["taxonomy"];
        description = json["description"];
        parent = json["parent"];
        count = json["count"];
        filter = json["filter"];
        image = json["image"];
        phone = json["phone"];
        address = json["address"];
        termLink = json["term_link"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["term_id"] = termId;
        _data["name"] = name;
        _data["slug"] = slug;
        _data["term_group"] = termGroup;
        _data["term_taxonomy_id"] = termTaxonomyId;
        _data["taxonomy"] = taxonomy;
        _data["description"] = description;
        _data["parent"] = parent;
        _data["count"] = count;
        _data["filter"] = filter;
        _data["image"] = image;
        _data["phone"] = phone;
        _data["address"] = address;
        _data["term_link"] = termLink;
        return _data;
    }
}