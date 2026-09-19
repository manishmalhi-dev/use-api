
class RegisterLink {
  static const register = "https://api.restful-api.dev/register";
  // static const
}

class Collections {
  static const collection = "https://api.restful-api.dev/collections";
// static const
}

class LoginApi{
  static const Login = "https://api.restful-api.dev/login";
}

class AddCollection{
  static String Login(String name){
    return "https://api.restful-api.dev/collections/${name.toLowerCase()}/objects";
  }
}




