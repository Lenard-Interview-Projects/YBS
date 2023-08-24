//
//  TestUtil.swift
//  ybs-interviewTests
//
//  Created by Lenard Pop on 28/08/2023.
//

import Foundation
import XCTest

public class TestUtil {
    public static let shared = TestUtil()

    private init () {}

    public func convertJSONtoObject<T: Decodable>(fileName: String) -> T? {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            XCTFail("Missing file: \(fileName).json")
            return nil
        }

        guard let jsonData = try? Data(contentsOf: url) else {
            XCTFail("Could not read contents of file")
            return nil
        }

        let decoder = JSONDecoder()
        return try? decoder.decode(T.self, from: jsonData)
    }
}
