//
//  RecipeCreateRequest.swift
//  EatCook
//
//  Created by 이명진 on 7/20/24.
//

import Foundation

struct RecipeCreateRequest: Codable {
    var email: String = "itcook1@gmail.com"
    var recipeName: String = ""
    var recipeTime: Int = 0
    var introduction: String = ""
    var mainFileExtension: String = ""
    var foodIngredients: [String] = []
    var cookingType: [String] = []
    var recipeProcess: [RecipeProcess] = []
}

struct RecipeProcess: Codable {
    var stepNum: Int
    var recipeWriting, fileExtension: String
}

extension RecipeCreateRequest {
    func toData() -> RecipeCreateRequestDTO {
        return .init(email: email,
                     recipeName: recipeName,
                     recipeTime: recipeTime,
                     introduction: introduction,
                     mainFileExtension: mainFileExtension,
                     foodIngredients: foodIngredients,
                     cookingType: cookingType,
                     recipeProcess: recipeProcess.map { $0.toData()} )
    }
}

extension RecipeProcess {
    func toData() -> RecipeProcessDTO {
        return .init(stepNum: stepNum,
                     recipeWriting: recipeWriting,
                     fileExtension: fileExtension)
    }
}

/// 요청 응답값
struct RecipeCreateResponse: Codable {
    let success: Bool
    let code, message: String
    let data: ResponseData
}

struct ResponseData: Codable {
    var mainPresignedUrl: String = ""
    var recipeProcessPresignedUrl: [String] = []
}
