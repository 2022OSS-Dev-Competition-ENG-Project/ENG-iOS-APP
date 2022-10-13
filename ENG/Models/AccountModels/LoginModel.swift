//
//  LoginModel.swift
//  ENG
//
//  Created by 정승균 on 2022/08/24.
//

import Foundation

// REQUEST DATA
/*
 {
    "userEmail" : "cb7856@naver.com",
    "userPassword" : "1234"
 }
*/
struct LoginRequest: Codable {
    let userEmail: String
    let userPassword: String
}

// RESPONSE DATA
/*
 {
     "token" : eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJjYjc4NTZAbmF2ZXIuY29tIiwibmFtZSI6ImNiNzg1NkBuYXZlci5jb20iLCJleHAiOjE2NjEzMTY4MDh9.bitRUU3WN15TZ-ujcVQfW_1-7HpkYScUuNDnylU12s8
 }
 */



struct LoginResponse: Codable {
    let body: String
}


