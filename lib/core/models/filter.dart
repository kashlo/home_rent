import 'property.dart';

class SearchFilter {
  int priceFrom;
  int priceTo;
  List<int> facilitiesIds;
  bool animalsAllowed;
  bool childrenAllowed;
  bool notFirstFloor;
  bool notLastFloor;
  PropertyType type;

  SearchFilter({
//    this.id,
    this.priceFrom,
    this.priceTo,
    this.facilitiesIds,
    this.animalsAllowed,
    this.childrenAllowed,
    this.notFirstFloor,
    this.notLastFloor,
    this.type
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};

    json.putIfAbsent('type', () => Property.typeToJson(type));

    if (priceFrom != null) {
      json.putIfAbsent('priceFrom', () => priceFrom);
    }
    if (priceTo != null) {
      json.putIfAbsent('priceTo', () => priceTo);
    }
    if (facilitiesIds != null) {
      json.putIfAbsent('facilitiesIds', () => facilitiesIds.join(","));
    }
    if (animalsAllowed != null) {
      json.putIfAbsent('animalsAllowed', () => animalsAllowed);
    }
    if (childrenAllowed != null) {
      json.putIfAbsent('childrenAllowed', () => childrenAllowed);
    }
    if (notFirstFloor != null) {
      json.putIfAbsent('notFirstFloor', () => notFirstFloor);
    }
    if (notLastFloor != null) {
      json.putIfAbsent('notLastFloor', () => notLastFloor);
    }
    return json;
  }
}