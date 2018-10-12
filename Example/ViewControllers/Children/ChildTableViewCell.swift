//
//  ChildTableViewCell.swift
//  Example
//
//  Created by minjuniMac on 12/10/2018.
//  Copyright © 2018 mjun. All rights reserved.
//

import UIKit

final class ChildTableViewCell: UITableViewCell {
    var img: UIImageView = {
        let _img = UIImageView()
        _img.contentMode = .scaleToFill
        _img.layer.masksToBounds = true
        _img.layer.cornerRadius = 50
        return _img
    }()
    var name: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.preferredFont(forTextStyle: .headline)
        lb.textColor = .black
        lb.numberOfLines = 0
        return lb
    }()
    
    var explanation: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.preferredFont(forTextStyle: .body)
        lb.textColor = .gray
        lb.numberOfLines = 0
        return lb
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.addSubviews([img, name, explanation])
        
        img.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: 0).isActive = true
        img.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: 0).isActive = true
        img.widthAnchor.constraint(equalToConstant: 100).isActive = true
        img.heightAnchor.constraint(equalToConstant: 100).isActive = true
        img.translatesAutoresizingMaskIntoConstraints = false
        
        name.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: 0).isActive = true
        name.leadingAnchor.constraint(equalTo: img.trailingAnchor, constant: 8).isActive = true
        name.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor, constant: 0).isActive = true
        name.translatesAutoresizingMaskIntoConstraints = false
        
        explanation.topAnchor.constraint(equalTo: name.lastBaselineAnchor, constant: 8).isActive = true
        explanation.leadingAnchor.constraint(equalTo: img.trailingAnchor, constant: 8).isActive = true
        explanation.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor, constant: 0).isActive = true
        explanation.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor, constant: 0).isActive = true
        explanation.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configure(image: UIImage, name: String, explanation: String) {
        img.image = image
        self.name.text = name
        self.explanation.text = explanation
    }
}

