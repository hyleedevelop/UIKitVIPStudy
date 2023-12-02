//
//  DetailModel.swift
//  UIKitVIPStudy
//
//  Created by Eric on 12/1/23.
//

import Foundation

/// Detail 화면에서 각 컴포넌트끼리 통신을 위해 사용하는 모델
struct DetailModel {
    
    /// 깃허브 사용자의 상세 정보를 표시할 때 사용하는 모델
    struct DisplayUserInfoDetails {
        struct Request {
            let data: UserInfo?
        }
        struct ViewModel {
            let tableViewData: [(String, String)]
        }
    }
    
    /// 다른 상황에서 사용하는 모델
    struct OtherCases {
        // ...
    }
    
}
