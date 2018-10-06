//
//  PhotoModel.swift
//  NagwaIosTask
//
//  Created by Ahmed Fitoh on 10/6/18.
//  Copyright © 2018 Nagwa. All rights reserved.
//

import Foundation

typealias GithubModel = [GithubModelElement]

struct GithubModelElement: Codable  {
    let id: Int
    let name, fullName: String
    let watchersCount: Int
    let forksCount: Int

    
    enum CodingKeys: String, CodingKey {
        case id, name
        case fullName = "full_name"
        case watchersCount = "watchers_count"
        case forksCount = "forks_count"
    }
}


