//
//  NotesTableViewCell.swift
//  ValueTypedCoreData
//
//  Created by Matt Tian on 2018/5/25.
//  Copyright © 2018 TeetBox. All rights reserved.
//

import UIKit

class NotesTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        setupViews()
    }
    
    let content: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.text = "I like programming with Swift. It is a cool language. Easy to learn and easy to master."
        return label
    }()
    
    let username: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.darkGray
        label.text = "John"
        return label
    }()
    
    let email: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .darkGray
        label.text = "john@gmail.com"
        return label
    }()
    
    func setupViews() {
        addSubview(content)
        addConstraints(format: "H:|-15-[v0]-15-|", views: content)
        addConstraints(format: "V:|-10-[v0]", views: content)
        
        addSubview(username)
        addConstraints(format: "H:|-15-[v0]", views: username)
        addConstraints(format: "V:[v0]-5-|", views: username)
        username.topAnchor.constraint(equalTo: content.bottomAnchor, constant: 10).isActive = true
        
        addSubview(email)
        addConstraints(format: "H:[v0]-15-|", views: email)
        email.centerYAnchor.constraint(equalTo: username.centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
