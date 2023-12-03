//
//  HomeSceneNetworkingWorker.swift
//  UIKitVIPStudy
//
//  Created by Eric on 11/30/23.
//

import Foundation

/// https://api.github.com/users/[사용자계정]
/// 깃허브에서 사용자 정보를 불러오는 API

//MARK: - 에러 타입 선언

enum NetworkingError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

//MARK: - 속성 선언 및 초기화

final class HomeNetworkingWorker {
    
}

//MARK: - Interactor -> NetworkingWorker 통신

extension HomeNetworkingWorker: HomeNetworkingLogic {
    
    func startFetching(with request: HomeModel.FetchUserInfo.Request) async throws -> HomeModel.FetchUserInfo.Response {
#if DEBUG
        // 일부러 네트워킹 시간을 지연시켜 봄
        sleep(1)
#endif
        
        // 1. url 문자열을 이용해 URL 오브젝트 생성
        let id = request.id
        let urlString = "https://api.github.com/users/\(id)"
        guard let url = URL(string: urlString) else { throw NetworkingError.invalidURL }
        
        // 2. 비동기적으로 네트워킹을 수행하고, 데이터와 응답 코드를 받아옴
        let (data, response) = try await URLSession.shared.data(from: url)
        
        // 3. 응답 코드가 200(모든 것이 정상인 경우)이 아니면 에러 발생
        guard let response = response as? HTTPURLResponse,
              response.statusCode == 200 else {
            throw NetworkingError.invalidResponse
        }
        
        // 4. 정상적으로 데이터를 받아온 경우 디코딩을 수행하고,
        //    디코딩에 문제가 있으면 에러 발생
        do {
            let decoder = JSONDecoder()
            // ex) abc_def -> abcDef (snake case -> camel case)
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            return try decoder.decode(HomeModel.FetchUserInfo.Response.self, from: data)
        } catch {
            throw NetworkingError.invalidData
        }
    }
    
}
