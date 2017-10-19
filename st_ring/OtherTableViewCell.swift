//
//  OtherTableViewCell.swift
//  st_ring
//
//  Created by EuiSuk_Lee on 2017. 10. 18..
//  Copyright © 2017년 EuiSuk_Lee. All rights reserved.
//

import UIKit

class OtherTableViewCell: UITableViewCell {
    
    let textView : UITextView = {
        let tv = UITextView()
        tv.text = "TEST TEXT"
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .clear
        tv.textColor = .black
        tv.isEditable = false
        tv.isSelectable = false
        tv.isScrollEnabled = false
        return tv
    }()
    let bubbleView : UIView = {
        let bv = UIView()
        bv.backgroundColor = UIColor.lightGray
        bv.translatesAutoresizingMaskIntoConstraints = false
        bv.layer.cornerRadius = 10
        bv.layer.masksToBounds = true
        return bv
    }()
    
    var bubbleWidthAnchor: NSLayoutConstraint?
    var bubbleHeightAnchor: NSLayoutConstraint?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //addview
        self.contentView.addSubview(bubbleView)
        bubbleView.addSubview(textView)
        
        //bubbleview constraint set
        bubbleView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        bubbleView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        bubbleView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        bubbleWidthAnchor = bubbleView.widthAnchor.constraint(equalToConstant: 200)
        bubbleWidthAnchor?.isActive = true
        
        //textview constraint set
        textView.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor, constant: 5).isActive = true
        textView.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: -5).isActive = true
        textView.topAnchor.constraint(equalTo: bubbleView.topAnchor, constant: 5).isActive = true
        textView.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor, constant: 5).isActive = true
        textView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
