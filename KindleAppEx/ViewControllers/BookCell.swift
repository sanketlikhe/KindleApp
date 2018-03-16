//
//  BookCell.swift
//  KindleAppEx
//
//  Created by sanket rajendra likhe on 13/03/18.
//  Copyright © 2018 sanket rajendra likhe. All rights reserved.
//

import UIKit

class BookCell: UITableViewCell {

    let coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        [coverImageView, titleLabel, authorLabel].forEach({ addSubview($0) })
        NSLayoutConstraint.activate([
            coverImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8),
            coverImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            coverImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            coverImageView.widthAnchor.constraint(equalToConstant: 50),
            
            titleLabel.leftAnchor.constraint(equalTo: coverImageView.rightAnchor, constant: 8),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -10),
            
            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            authorLabel.leftAnchor.constraint(equalTo: coverImageView.rightAnchor, constant: 8),
            authorLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8),
            authorLabel.heightAnchor.constraint(equalToConstant: 20),
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
