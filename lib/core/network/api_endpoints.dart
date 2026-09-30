class ApiEndpoints {
  static const String baseUrl =
      'https://api.restful-api.dev';

  static const register = "/register";
  static const login = "/login";

  static String addCategory(String name){
    return "/collections/${name.toLowerCase()}/objects";
  }
  // Get Data, Delete Data , update Object Data , Post New Object
  static String modifyObjectData(String id, String object){
    return "/collections/$object/objects/$id";
  }
  
}