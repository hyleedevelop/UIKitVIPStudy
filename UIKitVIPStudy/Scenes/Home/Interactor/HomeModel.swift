//
//  HomeModel.swift
//  UIKitVIPStudy
//
//  Created by Eric on 11/30/23.
//

import UIKit

/// Home 화면에서 각 컴포넌트끼리 통신을 위해 사용하는 모델
struct HomeModel {
    
    /// API 서버로부터 깃허브 사용자 정보를 가져올 때 사용하는 모델
    struct FetchUserInfo {
        struct Request {
            let id: String
        }
        struct Response: Decodable {
            let avatarUrl: String
            let login: String
            let name: String
            let bio: String
            let location: String
            let publicRepos: Int
            let publicGists: Int
            let followers: Int
            let following: Int
        }
        struct ViewModel {
            let imageURL: String
            let id: String
        }
    }
    
    /// 다른 상황에서 사용하는 모델
    struct OtherCases {
        // ...
    }
    
}
