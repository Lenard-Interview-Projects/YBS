//
//  ContentStringModel.swift
//  YBSServices
//
//  Created by Lenard Pop on 27/08/2023.
//

public struct ContentStringModel: Codable {
    public let _content: String

    public init() {
        self._content = ""
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        _content = try container.decode(String.self, forKey: ._content).toUnicodeEscapeSequences()
    }

    enum CodingKeys: String, CodingKey {
        case _content = "_content"
    }
}

public struct ContentIntModel: Codable {
    public let _content: Int

    public init() {
        self._content = 0
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        _content = try container.decode(Int.self, forKey: ._content)
    }

    enum CodingKeys: String, CodingKey {
        case _content = "_content"
    }
}
