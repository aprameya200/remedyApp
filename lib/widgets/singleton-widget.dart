class Singleton {
  static final Singleton _instance = Singleton._internal();

  // using a factory is important
  // because it promises to return _an_ object of this type
  // but it doesn't promise to make a new one.
  factory Singleton() {
    return _instance;
  }

  // This named constructor is the "real" constructor
  // It'll be called exactly once, by the static property assignment above
  // it's also private, so it can only be called in this class
  Singleton._internal() {
    // initialization logic
  }

  static List userData = [];

  void setUserData(List user) {
    userData = user;
  }

  void deteleUserData() {
    userData.clear();
  }

  static List getUserData() {
    return userData;
  }
}

class SingletonDoctors {
  static final SingletonDoctors _instance = SingletonDoctors._internal();

  // using a factory is important
  // because it promises to return _an_ object of this type
  // but it doesn't promise to make a new one.
  factory SingletonDoctors() {
    return _instance;
  }

  // This named constructor is the "real" constructor
  // It'll be called exactly once, by the static property assignment above
  // it's also private, so it can only be called in this class
  SingletonDoctors._internal() {
    // initialization logic
  }

  static List userData = [];

  void setUserData(List user) {
    userData = user;
  }

  void deteleUserData() {
    userData.clear();
  }

  static List getUserData() {
    return userData;
  }
}

class AboutDoctorData {
  static final AboutDoctorData _instance = AboutDoctorData._internal();

  // using a factory is important
  // because it promises to return _an_ object of this type
  // but it doesn't promise to make a new one.
  factory AboutDoctorData() {
    return _instance;
  }

  // This named constructor is the "real" constructor
  // It'll be called exactly once, by the static property assignment above
  // it's also private, so it can only be called in this class
  AboutDoctorData._internal() {
    // initialization logic
  }

  static List aboutDoctor = [];

  static String doctor = "";

  void setString(String user) {
    doctor = user;
  }

  static String getString() {
    return doctor;
  }

  void setUserData(List user) {
    aboutDoctor = user;
  }

  void addUserData(String user) {
    aboutDoctor.add(user);
  }

  void deteleUserData() {
    aboutDoctor.clear();
  }

  static List getUserData() {
    return aboutDoctor;
  }
}
