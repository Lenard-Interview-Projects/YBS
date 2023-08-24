//
//  PhotoServiceProtocol.swift
//  YBSServices
//
//  Created by Lenard Pop on 27/08/2023.
//

import Foundation
import Combine

public protocol PhotoServicesProtocol {
    func fetchPhotoInfo(photoId: String) -> AnyPublisher<PhotoResponseModel, Error>
}
