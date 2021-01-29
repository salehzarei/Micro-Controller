class DataModel {
  String mode;
  String shot;
  String m;
  String e;
  String dir;
  String slid;
  String st;
  String batt;

  DataModel(
      {this.mode,
      this.shot,
      this.m,
      this.e,
      this.dir,
      this.slid,
      this.st,
      this.batt});

  DataModel.fromJson(Map<String, dynamic> json) {
    mode = json['mode'];
    shot = json['shot'];
    m = json['m'];
    e = json['e'];
    dir = json['dir'];
    slid = json['slid'];
    st = json['st'];
    batt = json['batt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mode'] = this.mode;
    data['shot'] = this.shot;
    data['m'] = this.m;
    data['e'] = this.e;
    data['dir'] = this.dir;
    data['slid'] = this.slid;
    data['st'] = this.st;
    data['batt'] = this.batt;
    return data;
  }
}
