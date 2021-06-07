class User {
  String id;
  String fname;
  String lname;
  String token;
  User({
    this.fname,
    this.lname,
    this.id,
    this.token,
  });

  @override
  String toString() {
    return 'id: ' +
        this.fname +
        '\nfname: ' +
        this.fname +
        '\nlname: ' +
        this.lname +
        '\ntoken: ' +
        this.token;
  }
}
