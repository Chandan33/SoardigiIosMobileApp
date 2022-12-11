//
//  CommomModel.swift
//  Netpune Security
//
//  Created by Developer on 12/04/21.
//

import Foundation

struct LanguageResponseMainModel:Mappable {
    let status : Bool?
    var languages:[LanguageResponseModel]?
    enum CodingKeys: String, CodingKey {
        case status  = "success"
        case languages = "languages"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
       status = try values.decodeIfPresent(Bool.self, forKey: .status)
        guard let languages =  try values.decodeIfPresent([LanguageResponseModel].self, forKey: .languages) else{ return }
        self.languages = languages
    }
}


struct BusinessCategoryResponseMainModel:Mappable {
    let status : Bool?
    var businessCategoryResponseModel:[BusinessCategoryResponseModel]?
    enum CodingKeys: String, CodingKey {
        case status  = "success"
        case businessCategoryResponseModel = "categories"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
       status = try values.decodeIfPresent(Bool.self, forKey: .status)
        guard let businessCategoryResponseModel =  try values.decodeIfPresent([BusinessCategoryResponseModel].self, forKey: .businessCategoryResponseModel) else{ return }
        self.businessCategoryResponseModel = businessCategoryResponseModel
    }
}


struct BusinessFrameResponseMainModel:Mappable {
    let status : Bool?
    var frames:[ImageFrameResponseModel]?
    enum CodingKeys: String, CodingKey {
        case status  = "success"
        case frames = "frames"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
       status = try values.decodeIfPresent(Bool.self, forKey: .status)
        guard let frames =  try values.decodeIfPresent([ImageFrameResponseModel].self, forKey: .frames) else{ return }
        self.frames = frames
    }
}

struct SaveBusinessFrameResponseMainModel:Mappable {
    let status : Bool?
   
    enum CodingKeys: String, CodingKey {
        case status  = "success"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
       status = try values.decodeIfPresent(Bool.self, forKey: .status)
    }
}


struct BusinessSaveResponseMainModel:Mappable {
    let status : Bool?
    let message, token: String?
    enum CodingKeys: String, CodingKey {
        case status  = "success"
        case message = "message"
        case token = "token"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
       status = try values.decodeIfPresent(Bool.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        token = try values.decodeIfPresent(String.self, forKey: .token)
    }
}

struct UserResponseModel1:Mappable {
   
    let message,token : String?
   
    enum CodingKeys: String, CodingKey {
       
        case message = "message"
        case token = "token"
        
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        message =   try values.decodeIfPresent(String.self, forKey: .message)
        token =   try values.decodeIfPresent(String.self, forKey: .token)
       
    }
}



struct LanguageResponseModel:Mappable {
   
    let name: String?
    let id:Int?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case id = "id"
      }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name =   try values.decodeIfPresent(String.self, forKey: .name)
        id =   try values.decodeIfPresent(Int.self, forKey: .id)
    }
}


struct BusinessCategoryResponseModel:Mappable {
   
    let name,thumbnail: String?
    let id:Int?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case thumbnail = "thumbnail"
        case id = "id"
      }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name =   try values.decodeIfPresent(String.self, forKey: .name)
        thumbnail =   try values.decodeIfPresent(String.self, forKey: .thumbnail)
        id =   try values.decodeIfPresent(Int.self, forKey: .id)
    }
}


struct ImageFrameResponseModel:Mappable {
   
    let img_url: String?
    let id:Int?
    var selected:Bool = false
    
    enum CodingKeys: String, CodingKey {
        case img_url = "img_url"
        case id = "id"
      }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        img_url =   try values.decodeIfPresent(String.self, forKey: .img_url)
       
        id =   try values.decodeIfPresent(Int.self, forKey: .id)
    }
}
