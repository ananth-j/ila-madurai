class mainScreenSuperLogicJson {
  final todaycollection;
  final fill;
  final empty;

  const mainScreenSuperLogicJson({
    required this.todaycollection,
    required this.fill,
    required this.empty,
  });

  Map<String, dynamic> mainJson() => {
        'todaycollection': todaycollection,
        "fill": fill,
        "empty": empty,
        'remainig': fill,
        'closingfill': 0,
        'closingempty': 0,
      };
}
