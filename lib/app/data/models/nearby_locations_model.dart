
class LocationModel {
    String? termId;
    String? name;
    String? metaKey;
    String? cityLat;
    String? cityLong;
    String? address;
    String? phone;
    String? image;
    String? distance;
    String? termLink;

    LocationModel({this.termId, this.name, this.metaKey, this.cityLat, this.cityLong, this.address, this.phone, this.image, this.distance, this.termLink});

    LocationModel.fromJson(Map<String, dynamic> json) {
        termId = json["term_id"];
        name = json["name"];
        metaKey = json["meta_key"];
        cityLat = json["cityLat"];
        cityLong = json["cityLong"];
        address = json["address"];
        phone = json["phone"];
        image = json["image"];
        distance = json["distance"];
        termLink = json["term_link"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["term_id"] = termId;
        _data["name"] = name;
        _data["meta_key"] = metaKey;
        _data["cityLat"] = cityLat;
        _data["cityLong"] = cityLong;
        _data["address"] = address;
        _data["phone"] = phone;
        _data["image"] = image;
        _data["distance"] = distance;
        _data["term_link"] = termLink;
        return _data;
    }
}