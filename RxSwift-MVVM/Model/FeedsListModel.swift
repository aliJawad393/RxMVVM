
import Foundation


struct PostsListResponse : Codable {
    let data : [FeedsListModel]?

    enum CodingKeys: String, CodingKey {

        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([FeedsListModel].self, forKey: .data)
    }

}

public struct FeedsListModel: Codable {
    
  let id : Int?
    let fb_id : String?
    let ig_id : String?
    let is_active : Int?
    let igb_account_id : Int?
    let likes : Int?
    let comments : Int?
    let shortcode : String?
    let permalink : String?
    let media_type : String?
    let media_url : String?
    let created_at : String?
    let updated_at : String?
    let thumbnail_url : String?
    let caption : String?
    let is_story : Int?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case fb_id = "fb_id"
        case ig_id = "ig_id"
        case is_active = "is_active"
        case igb_account_id = "igb_account_id"
        case likes = "likes"
        case comments = "comments"
        case shortcode = "shortcode"
        case permalink = "permalink"
        case media_type = "media_type"
        case media_url = "media_url"
        case created_at = "created_at"
        case updated_at = "updated_at"
        case thumbnail_url = "thumbnail_url"
        case caption = "caption"
        case is_story = "is_story"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        fb_id = try values.decodeIfPresent(String.self, forKey: .fb_id)
        ig_id = try values.decodeIfPresent(String.self, forKey: .ig_id)
        is_active = try values.decodeIfPresent(Int.self, forKey: .is_active)
        igb_account_id = try values.decodeIfPresent(Int.self, forKey: .igb_account_id)
        likes = try values.decodeIfPresent(Int.self, forKey: .likes)
        comments = try values.decodeIfPresent(Int.self, forKey: .comments)
        shortcode = try values.decodeIfPresent(String.self, forKey: .shortcode)
        permalink = try values.decodeIfPresent(String.self, forKey: .permalink)
        media_type = try values.decodeIfPresent(String.self, forKey: .media_type)
        media_url = try values.decodeIfPresent(String.self, forKey: .media_url)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
        thumbnail_url = try values.decodeIfPresent(String.self, forKey: .thumbnail_url)
        caption = try values.decodeIfPresent(String.self, forKey: .caption)
        is_story = try values.decodeIfPresent(Int.self, forKey: .is_story)
    }
}

enum MediaType: String, Codable {
    case carouselAlbum = "CAROUSEL_ALBUM"
    case image = "IMAGE"
    case video = "VIDEO"
    
}



