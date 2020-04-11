
import Foundation

//public class Generic_Base {
//    public var data : [BaseModel]?
//
//
//    public class func modelsFromDictionaryArray(array:NSArray) -> [BaseModel]
//    {
//        var models:[BaseModel] = []
//        for item in array
//        {
//            models.append(BaseModel(dictionary: item as! NSDictionary)!)
//        }
//        return models
//    }
//
//    required public init?(dictionary: NSDictionary) {
//
//        if (dictionary["data"] != nil) { data = BaseModel.modelsFromDictionaryArray(array: dictionary["data"] as! NSArray) }
//    }
//
//
//    public func dictionaryRepresentation() -> NSDictionary {
//
//        let dictionary = NSMutableDictionary()
//        return dictionary
//    }
//
//}
//
//public class BaseModel {
//	public var id : Int?
//	public var name : String?
//	public var username : String?
//	public var email : String?
//	public var phone : String?
//	public var website : String?
//
//    public class func modelsFromDictionaryArray(array:NSArray) -> [BaseModel]
//    {
//        var models:[BaseModel] = []
//        for item in array
//        {
//            models.append(BaseModel(dictionary: item as! NSDictionary)!)
//        }
//        return models
//    }
//
//	required public init?(dictionary: NSDictionary) {
//
//		id = dictionary["id"] as? Int
//		name = dictionary["name"] as? String
//		username = dictionary["username"] as? String
//		email = dictionary["email"] as? String
//		phone = dictionary["phone"] as? String
//		website = dictionary["website"] as? String
//	}
//
//	public func dictionaryRepresentation() -> NSDictionary {
//
//		let dictionary = NSMutableDictionary()
//
//		dictionary.setValue(self.id, forKey: "id")
//		dictionary.setValue(self.name, forKey: "name")
//		dictionary.setValue(self.username, forKey: "username")
//		dictionary.setValue(self.email, forKey: "email")
//		dictionary.setValue(self.phone, forKey: "phone")
//		dictionary.setValue(self.website, forKey: "website")
//
//		return dictionary
//	}
//}

struct WelcomeElement: Codable {
    let id: Int
    let name, username, email: String
    let address: Address
    let phone, website: String
    let company: Company
}

// MARK: - Address
struct Address: Codable {
    let street, suite, city, zipcode: String
    let geo: Geo
}

// MARK: - Geo
struct Geo: Codable {
    let lat, lng: String
}

// MARK: - Company
struct Company: Codable {
    let name, catchPhrase, bs: String
}
