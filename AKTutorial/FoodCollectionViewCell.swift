//
//  FoodCollectionViewCell.swift
//  AKTutorial
//
//  Created by Akkshay Khoslaa on 9/25/16.
//  Copyright © 2016 Akkshay Khoslaa. All rights reserved.
//

import UIKit

//Used to communicate between FoodCollectionViewCell and ViewController
protocol FoodColectionViewCellDelegate {
    func changeColorOfButton(forCell: FoodCollectionViewCell)
}

class FoodCollectionViewCell: UICollectionViewCell {
    
    var foodImageView: UIImageView!
    var button: UIButton!
    var delegate: FoodColectionViewCellDelegate? = nil
    
    override func awakeFromNib() {
        foodImageView = UIImageView(frame: contentView.frame)
        foodImageView.contentMode = .scaleAspectFill
        foodImageView.clipsToBounds = true
        contentView.addSubview(foodImageView) //Remember to add UI elements to the contentView, not the cell itself
        
        button = UIButton(frame: CGRect(x: (contentView.frame.width - 200)/2, y: (contentView.frame.height - 40)/2, width: 200, height: 40))
        button.backgroundColor = UIColor.green
        button.setTitle("Change My Color", for: .normal)
        button.layer.cornerRadius = 3
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(changeColor), for: .touchUpInside)
        contentView.addSubview(button)
    }
    
    func changeColor() {
        print("changing color")
        delegate?.changeColorOfButton(forCell: self)
    }
}
