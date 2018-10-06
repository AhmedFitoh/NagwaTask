//
//  HomeScreenGroupCell.swift
//  NagwaIosTask
//
//  Created by Ahmed Fitoh on 10/6/18.
//  Copyright © 2018 Nagwa. All rights reserved.
//

import UIKit

class HomeScreenGroupCell: UITableViewCell {

    
    @IBOutlet weak var titleLBL: UILabel!
    @IBOutlet weak var forksLBL: UILabel!
    @IBOutlet weak var watchersLBL: UILabel!
    @IBOutlet weak var profileIMG: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configureCell(input: GithubModelElement )  {
         titleLBL.text = input.fullName
         watchersLBL.text = "Watchers: \(input.watchersCount)"
         forksLBL.text = "Forks: \(input.forksCount)"
         selectionStyle = .none
    }

}
