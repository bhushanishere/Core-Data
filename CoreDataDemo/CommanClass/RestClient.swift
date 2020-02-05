//
//  RestClient.swift
//  AlamofireDemo
//
//  Created by Bhushan  Borse on 04/01/20.
//  Copyright © 2020 Bhushan  Borse. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RestClient: NSObject {
    
    /// If you have base url so please add here and appent endpoint url after that.ß
    let SERVER_URL  : String = ""
    let netManager = NetworkReachabilityManager(host: "Host_name".localizedString)

    func callApi(api :String,completion :@escaping (_:NSError?,_:JSON?)->Void, type:String = "GET", data:Any? = nil , isAbsoluteURL:Bool = false , headers : Any? = nil, isSilent : Bool = false) {
        
        if !(netManager?.isReachable)!{
         /// Show offline message
         print("Offline")
            return
        }
        
     /// If call api with showing loader
        if !isSilent {
         /// Show loader here...
         print("Show loader here...")
        }
     
        var urlTohit = ""
        
     /// Here we check url is complet or not otherwise add base url...
        if isAbsoluteURL {
            urlTohit = api
        } else {
            urlTohit = SERVER_URL + api
        }
        
        /// Check url is not empty.
        guard let url = URL(string:urlTohit) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = type
                  
        if headers != nil {
            var temp = headers as! [String : String];
            temp["Content-Type"] = "application/json"
            request.allHTTPHeaderFields = temp
        }

        /// Add parameter to httpBody
        if data != nil {
            request.httpBody = try! JSONSerialization.data(withJSONObject: data! , options: [])
        }
        
        /// Call URL
        AF.request(request as URLRequestConvertible).responseJSON() { response in
            switch response.result {
            case .success(let value):
                completion(nil, JSON(value))
            case .failure(let error):
                completion(error as NSError, JSON.null)
            }
        }
    }
    
    func showAlertView(message : String, from viewController : UIViewController)  {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
}

/*func fetchAllRooms(completion: @escaping (_:NSError?,_:JSON?) -> Void) {
  guard let url = URL(string: "http://localhost:5984/rooms/_all_docs?include_docs=true") else {
    completion(nil, nil)
    return
  }
  af.request(url,
                    method: .get,
                    parameters: ["include_docs": "true"])
  .validate()
  .responseJSON { response in
    guard response.result.isSuccess else {
      print("Error while fetching remote rooms: \(response.result.error)")
      completion(nil,)
      return
    }

    guard let value = response.result.value as? [String: Any],
      let rows = value["rows"] as? [[String: Any]] else {
        print("Malformed data received from fetchAllRooms service")
        completion(nil)
        return
    }

   // let rooms = rows.flatMap { roomDict in return RemoteRoom(jsonData: roomDict) }
    //completion(rooms)
  }
}*/

extension String {
    var localizedString: String {
        return NSLocalizedString(self, comment: self)
    }
}

class RestClientMessages : NSObject {
    static let kErrorDomain = "com.Domain.name"
    static let kOfflineMsg = "offline, please check your connection"
    static let noAuth = "Session Expired. Please login again!"
    static let kMsgString = "message"
}


