
class RegisterLink {
  static const register = "https://api.restful-api.dev/register";
  // static const
}
//
// class Collections {
//   static const collection = "https://api.restful-api.dev/collections";
// // static const
// }

class LoginApi{
  static const LoginUrl = "https://api.restful-api.dev/login";
}

class AddCollection{
  static String Login(String name){
    return "https://api.restful-api.dev/collections/${name.toLowerCase()}/objects";
  }
}

class GetSingleData{
  static String url(String id, String object){
    return "https://api.restful-api.dev/collections/$object/objects/$id";
  }
}


class PostData{
  static String postUrl(String object, String id){
    return "https://api.restful-api.dev/collections/$object/objects/$id";
  }
}


class DeletePost{
  static String DltUrl(String object, String id){
    return "https://api.restful-api.dev/collections/$object/objects/$id";
  }
}


class PutData{
  static String postUrl(String object, String id){
    return "https://api.restful-api.dev/collections/$object/objects/$id";
  }
}

