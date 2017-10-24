//
//  MYEditTableViewCell.swift
//  st_ring
//
//  Created by EuiSuk_Lee on 2017. 10. 17..
//  Copyright © 2017년 EuiSuk_Lee. All rights reserved.
//

import UIKit

class MYEditTableViewCell: UITableViewCell {
    
    let textView : UITextView = {
        let tv = UITextView()
        tv.text = "TEST TEXT"
        tv.font = UIFont.systemFont(ofSize: 14)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .clear
        tv.textColor = .white
        tv.isEditable = false
        tv.isSelectable = false
        tv.isScrollEnabled = false
//        tv.mult
        return tv
    }()
    let editButton : UIButton = {
        let eb = UIButton()
        eb.setTitle("수정하기", for: UIControlState.normal)
        eb.translatesAutoresizingMaskIntoConstraints = false
        eb.isEnabled = true
        eb.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return eb
    }()
    let bubbleView : UIView = {
        let bv = UIView()
        bv.backgroundColor = UIColor.blue
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
        bubbleView.addSubview(editButton)
        
        //textview constraint set
        textView.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor, constant: 5).isActive = true
        textView.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: -5).isActive = true
        textView.topAnchor.constraint(equalTo: bubbleView.topAnchor, constant: 5).isActive = true
        textView.bottomAnchor.constraint(equalTo: editButton.topAnchor).isActive = true
        
        
        //editbutton constraint set
        editButton.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor, constant: 10).isActive = true
        editButton.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: -10).isActive = true
        editButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        editButton.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor).isActive = true
        
        //bubbleview constraint set
        bubbleView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        bubbleView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        bubbleView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant:-5).isActive = true
        bubbleWidthAnchor = bubbleView.widthAnchor.constraint(equalToConstant: 200)
        bubbleWidthAnchor?.isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
