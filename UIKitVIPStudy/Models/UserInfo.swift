//
//  UserInfo.swift
//  UIKitVIPStudy
//
//  Created by Eric on 12/1/23.
//

import Foundation

/// 앱 전반에서 깃허브 사용자 정보를 담기 위해 사용하는 기본 모델
struct UserInfo {
    let imageURL: String
    let id: String
    let name: String
    let bio: String
    let location: String
    let publicRepositories: Int
    let publicGists: Int
    let followers: Int
    let following: Int
}
