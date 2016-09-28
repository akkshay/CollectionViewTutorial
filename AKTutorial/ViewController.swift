//
//  ViewController.swift
//  AKTutorial
//
//  Created by Akkshay Khoslaa on 9/25/16.
//  Copyright © 2016 Akkshay Khoslaa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var collectionView: UICollectionView!
    var images = [UIImage(named: "food1"), UIImage(named: "food2"), UIImage(named: "food3"), UIImage(named: "food4"), UIImage(named: "food5")]
    var numImages = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupCollectionView()
        addMoreImages()
        deleteLastImage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Initializing a collectionView and adding it to the VC's current view
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.register(FoodCollectionViewCell.self, forCellWithReuseIdentifier: "foodCell")
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
    }
    
    //Add more images to the collectionView
    func addMoreImages() {
        let moreImages =  [UIImage(named: "food6"), UIImage(named: "food7"), UIImage(named: "food8"), UIImage(named: "food9"), UIImage(named: "food10")]
        images.append(contentsOf: moreImages)
        var indexPaths = Array<IndexPath>()
        for image in moreImages {
            let index = images.index(where: {$0 == image})
            let indexPath = IndexPath(item: index!, section: 0)
            indexPaths.append(indexPath)
        }
        collectionView.performBatchUpdates({Void in
            self.collectionView.insertItems(at: indexPaths)
            self.numImages += 5
            }, completion: nil)
    }
    
    //Delete the last image in the collectionView
    func deleteLastImage() {
        var indexPaths = Array<IndexPath>()
        indexPaths.append(IndexPath(item: images.count - 1, section: 0))
        collectionView.performBatchUpdates({ Void in
            self.collectionView.deleteItems(at: indexPaths)
            self.numImages -= 1
            }, completion: nil)
    }
   
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //Specifying the number of sections in the collectionView
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //Specifying the number of cells in the given section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numImages
    }
    
    //We use this method to dequeue the cell and set it up
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "foodCell", for: indexPath) as! FoodCollectionViewCell
        cell.awakeFromNib()
        cell.delegate = self
        return cell
    }
    
    //We use this method to populate the data of a given cell
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let foodCell = cell as! FoodCollectionViewCell
        foodCell.foodImageView.image = images[indexPath.row]
    }
    
    //Sets the size of the cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
    //If we want something to happen when the user taps a cell, then use this method
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print(indexPath.row)
//    }
}

extension ViewController: FoodColectionViewCellDelegate {
    func changeColorOfButton(forCell: FoodCollectionViewCell) {
        forCell.button.backgroundColor = UIColor.blue
    }
}

