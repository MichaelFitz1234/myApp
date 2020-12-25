//
//  PlayerStatsCells.swift
//  BasketballAppTwo
//
//  Created by Michael Fitzgerald on 12/5/20.
//

import UIKit

class PlayerStatsCells: UITableViewCell {
    let labelForScore = UILabel()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.addSubview(labelForScore)
        labelForScore.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor)
            labelForScore.text = "the score is 12 to 10"
            labelForScore.font = .systemFont(ofSize: 18, weight: .bold)
            labelForScore.textColor = .white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
