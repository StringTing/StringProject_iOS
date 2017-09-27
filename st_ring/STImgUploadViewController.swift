//
//  STImgUploadViewController.swift
//  st_ring
//
//  Created by EuiSuk_Lee on 2017. 9. 24..
//  Copyright © 2017년 EuiSuk_Lee. All rights reserved.
//

import UIKit

class STImgUploadViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var progressImg: UIImageView!
    @IBOutlet weak var certificationLabel: UILabel!
    @IBOutlet weak var certificationBtn: UIButton!
    @IBOutlet weak var certificationImg: UIImageView!
    @IBOutlet weak var profilLabel: UILabel!
    @IBOutlet weak var profilGuideLabel: UILabel!
    @IBOutlet weak var uploadCollection: UICollectionView!
    @IBOutlet weak var NextBtn: UIButton!
    
    var profilImg : [UIImage] = [UIImage(named : "defualt")!, UIImage(named :"defualt")!, UIImage(named :"defualt")!, UIImage(named :"defualt")!, UIImage(named :"defualt")!, UIImage(named : "defualt")!]
    var uploadLabel : [String] = [
    "메인 사진\n(필수)",
    "전신 사진\n(선택)",
    "프로필 사진1 \n(필수)",
    "프로필 사진2 \n(필수)",
    "프로필 사진3 \n(선택)",
    "프로필 사진4 \n(선택)"
        ]
    let certificationPicker = UIImagePickerController()
    let cellPicker = UIImagePickerController()
    var currentIndexPathrow : Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        certificationPicker.delegate = self
        cellPicker.delegate  = self
        
        NextBtn.isEnabled = false
        NextBtn.backgroundColor = UIColor.lightGray
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func NextBtn(_ sender: Any) {
        guard let next = self.storyboard?.instantiateViewController(withIdentifier: "STQAViewController") else {
            return
        }
        self.navigationController?.pushViewController(next, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imgUploadCollectionViewCell", for: indexPath)
        as! imgUploadCollectionViewCell
        
        cell.CellLabel.text! = uploadLabel[indexPath.row]
        cell.cellBtn.addTarget(self, action: #selector(self.uploadCell), for: .touchUpInside)
        cell.cellImg.image = profilImg[indexPath.row]
        cell.cellBtn.tag = indexPath.row
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        uploadCollection.reloadData()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        var counter : Int = 0
        
        if(picker == certificationPicker){
            certificationImg.image = chosenImage
        }else if(picker == cellPicker){
            if let a = currentIndexPathrow {
                profilImg[a] = chosenImage
                print("run")
            }
        }
        dismiss(animated: true, completion: nil)
        uploadCollection.reloadData()
        
        for a in profilImg {
            if (a != UIImage(named : "defualt")){
                counter += 1
            }
        }
        if counter >= 3 {
            self.NextBtn.isEnabled = true
            self.NextBtn.backgroundColor = UIColor.black
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func certifucationBtn(_ sender: Any) {
        certificationPicker.allowsEditing = false
        certificationPicker.sourceType = .photoLibrary
        self.present(certificationPicker, animated: true, completion: nil)
    }
    
    func uploadCell(sender : UIButton) {
        cellPicker.allowsEditing = false
        cellPicker.sourceType = .photoLibrary
        self.currentIndexPathrow = sender.tag
        self.present(cellPicker, animated: true, completion: nil)
    }

}
