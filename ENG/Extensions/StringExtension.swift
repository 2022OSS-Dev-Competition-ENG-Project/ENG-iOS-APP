//
//  StringExtension.swift
//  ENG
//
//  Created by 정승균 on 2022/08/31.
//

import Foundation
import UIKit

extension String {
    /// 작업 에러
    /// - OutOfBounds : String Index 불러오기 실패시 발생하는 오류
    enum StringError: Error {
        case OutOfBounds
    }
    
    /// 인덱스 쉽게 구하기
    ///  ```
    /// var string: String = "Hello"
    /// string.insert("!", at: date.getIndex(at: 4))
    /// // The string value -> "Hell!o"
    ///  ```
    
    func getIndex(at index: Int) throws -> String.Index {
        guard index < self.count else { throw StringError.OutOfBounds }
        let returnIndex = self.index(self.startIndex, offsetBy: index)
        return returnIndex
    }
}
