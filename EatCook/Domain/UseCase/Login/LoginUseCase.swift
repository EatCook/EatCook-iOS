//
//  LoginUserCase.swift
//  EatCook
//
//  Created by 강신규 on 8/7/24.
//

import Foundation
import Combine

final class LoginUseCase {
    
    private let eatCookRepository: EatCookRepositoryType
    private var cancellabels = Set<AnyCancellable>()
    
    init(eatCookRepository: EatCookRepositoryType) {
        self.eatCookRepository = eatCookRepository
    }
    
}


extension LoginUseCase {
    
    
    func login(_ email : String , _ password : String , _ deviceToken : String) -> AnyPublisher<LoginResponse, NetworkError> {
        return eatCookRepository
            .login(of: LoginAPI.login(email, password, deviceToken))
            .eraseToAnyPublisher()
    }
    
    
    
}
