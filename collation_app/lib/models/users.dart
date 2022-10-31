class User {
  final int id;
  final String area;
  final String password;
  final String level;
  User(
    this.id,
    this.area,
    this.password,
    this.level,
  );
  List<User> users = [
    User(1, 'Legon A', 'awesomeA', 'pOfficer'),
    User(2, 'Legon B', 'awesomeM', 'pOfficer'),
    User(3, 'Legon', 'awesome', 'cOfficer'),
    User(4, 'Legon A', 'awesomeR', 'Party'),
    User(5, 'Legon B', 'awesomeE', 'Party'),
  ];
}
