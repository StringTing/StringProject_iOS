//
//  STBasicInfoViewController.swift
//  st_ring
//
//  Created by euisuk_lee on 2017. 9. 18..
//  Copyright © 2017년 EuiSuk_Lee. All rights reserved.
//

import UIKit

class STBasicInfoViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate {
    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var ContentsView: UIView!
    @IBOutlet weak var certificationBtn: UIButton!
    @IBOutlet weak var certificationView: UIView!
    @IBOutlet weak var uploadView: UIView!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var uploadCollection: UICollectionView!
    @IBOutlet weak var progressImg: UIImageView!
    @IBOutlet weak var gunBariLabel: UILabel!
    @IBOutlet weak var gunBarI: UISegmentedControl!
    @IBOutlet weak var gunBarICheck: UIView!
    @IBOutlet weak var schoolTextfield: selectTextField!
    @IBOutlet weak var schoolLabel: UILabel!
    @IBOutlet weak var schoolCheck: UIView!
    @IBOutlet weak var specialtyLabel: UILabel!
    @IBOutlet weak var specialtyTextfield: UITextField!
    @IBOutlet weak var specialtyCheck: UIView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var locationTextfield: selectTextField!
    @IBOutlet weak var locationCheck: UIView!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var heightTextfield: selectTextField!
    @IBOutlet weak var heightCheck: UIView!
    @IBOutlet weak var bodyCheck: UIView!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var bodyTextfield: selectTextField!
    @IBOutlet weak var smokeLabel: UILabel!
    @IBOutlet weak var smokeSegmented: UISegmentedControl!
    @IBOutlet weak var smokeCheck: UIView!
    @IBOutlet weak var drinkLabel: UILabel!
    @IBOutlet weak var drinkTextfield: selectTextField!
    @IBOutlet weak var drinkCheck: UIView!
    @IBOutlet weak var religionTextfield: selectTextField!
    @IBOutlet weak var religionCheck: UIView!
    @IBOutlet weak var bloodLabel: UILabel!
    @IBOutlet weak var bloodTextfield: selectTextField!
    @IBOutlet weak var bloodCheck: UIView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var BasicInfoLabel: UILabel!
    
    let gunbariArray = ["군필", "미필", "해당없음"]
    let schoolArray = ["인서울상위", "인서울4년제", "수도권4년제", "4년제", "전문대", "해외대학", "고졸"]
    let locationArray = ["서울", "부산", "인천", "광주", "울산", "대전", "대구", "경기", "강원", "경남", "경북", "충북", "충남", "전북", "전남"]
    let heightArray:[Int] = Array(140...200)
    let bloodArray = ["A", "B", "O", "AB"]
    let MbodyArray = ["마름", "슬림", "보통", "근육질", "통통한"]
    let WbodyArray = ["마름", "슬림", "보통", "글래머", "통통한"]
    let drinkArray = ["마시지 않음", "적당히 마심", "술자리를 즐김"]
    let religionArray = ["없음", "기독교", "불교", "천주교", "기타"]
    var profilImg : [UIImage] = [UIImage(named : "defualt")!, UIImage(named :"defualt")!, UIImage(named :"defualt")!, UIImage(named :"defualt")!, UIImage(named :"defualt")!, UIImage(named : "defualt")!]
    let uploadLabel : [String] = [
        "메인 사진\n(필수)",
        "전신 사진\n(선택)",
        "프로필 사진1 \n(필수)",
        "프로필 사진2 \n(필수)",
        "프로필 사진3 \n(선택)",
        "프로필 사진4 \n(선택)"
    ]
    let toolBar = UIToolbar()
    let certificationPicker = UIImagePickerController()
    let cellPicker = UIImagePickerController()

    var defualtPicker = UIPickerView()
    var schoolPicker = UIPickerView()
    var locationPicker = UIPickerView()
    var heightPicker = UIPickerView()
    var bloodPicker = UIPickerView()
    var drinkPicker = UIPickerView()
    var religionPicker = UIPickerView()
    var MbodyPicker = UIPickerView()
    var WbodyPicker = UIPickerView()
    var currentIndexPathrow : Int!
    var nextBtnYLocation:CGPoint!
    var sex = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.backAction))
        self.navigationItem.leftBarButtonItem = newBackButton
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(STBasicInfoViewController.tapView))
        tap.delegate = self as? UIGestureRecognizerDelegate
        self.view.addGestureRecognizer(tap)
        nextBtn.isEnabled = true
        nextBtn.backgroundColor = UIColor.white
        
        self.ContentsView.backgroundColor = UIColor.lightGray
        self.certificationView.layer.cornerRadius = 10
        self.uploadView.layer.cornerRadius = 10
        self.infoView.layer.cornerRadius = 10
        self.nextBtn.layer.cornerRadius = 10
        self.gunBarICheck.layer.cornerRadius = 5
        self.schoolCheck.layer.cornerRadius = 5
        self.specialtyCheck.layer.cornerRadius = 5
        self.locationCheck.layer.cornerRadius = 5
        self.heightCheck.layer.cornerRadius = 5
        self.bloodCheck.layer.cornerRadius = 5
        self.bodyCheck.layer.cornerRadius = 5
        self.smokeCheck.layer.cornerRadius = 5
        self.drinkCheck.layer.cornerRadius = 5
        self.religionCheck.layer.cornerRadius = 5
        
        
        schoolPicker.delegate = self
        locationPicker.delegate = self
        heightPicker.delegate = self
        bloodPicker.delegate = self
        drinkPicker.delegate = self
        religionPicker.delegate = self
        MbodyPicker.delegate = self
        WbodyPicker.delegate = self
        certificationPicker.delegate = self
        cellPicker.delegate  = self
        specialtyTextfield.delegate = self
        uploadCollection.delegate = self
        uploadCollection.dataSource = self
        
        schoolTextfield.inputView = schoolPicker
        locationTextfield.inputView = locationPicker
        heightTextfield.inputView = heightPicker
        drinkTextfield.inputView = drinkPicker
        religionTextfield.inputView = religionPicker
        bloodTextfield.inputView = bloodPicker
        if(sex == false){
            bodyTextfield.inputView = MbodyPicker
        } else {
            gunBarI.removeFromSuperview()
            gunBariLabel.removeFromSuperview()
            gunBarICheck.removeFromSuperview()
            let womenConst1 = NSLayoutConstraint(item: schoolLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: BasicInfoLabel, attribute:NSLayoutAttribute.bottom, multiplier: 1, constant: CGFloat(25))
            self.infoView.addConstraint(womenConst1)
            bodyTextfield.inputView = WbodyPicker
        }
        
        self.toolBar.barStyle = .default
        self.toolBar.isTranslucent = true
        self.toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        self.toolBar.setItems([spaceButton, doneButton], animated: false)
        self.toolBar.isUserInteractionEnabled = true
        
        let textFieldArray = [schoolTextfield, specialtyTextfield,  locationTextfield, heightTextfield, bodyTextfield, drinkTextfield, religionTextfield, bloodTextfield]
        
        for i in textFieldArray {
            i?.delegate = self
            i?.inputAccessoryView = self.toolBar
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let QAView = segue.destination as! STQAViewController
        var userBasicInfo = QAView.userBasicInfo
        userBasicInfo!.email = "eui970422@icloud.com"
        userBasicInfo!.password = "!Jp224079"
        userBasicInfo!.login_format = "F"
        userBasicInfo!.birthday = "1992-04-22"
        userBasicInfo!.military_service_status = self.gunBarI.titleForSegment(at: self.gunBarI.selectedSegmentIndex)
        userBasicInfo!.education = self.schoolTextfield?.text
        userBasicInfo!.department = self.specialtyTextfield?.text
        userBasicInfo!.location = self.locationTextfield?.text
        userBasicInfo!.height = self.heightTextfield?.text
        userBasicInfo!.body_form = self.bodyTextfield?.text
        if self.smokeSegmented.titleForSegment(at: self.smokeSegmented.selectedSegmentIndex) == "흡연자" {
            userBasicInfo!.smoke = true
        } else {
            userBasicInfo!.smoke = false
        }
        userBasicInfo!.drink = self.drinkTextfield?.text
        userBasicInfo!.religion = self.religionTextfield?.text
        userBasicInfo!.authenticated = false
        userBasicInfo!.id_image = "test_code"
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView == self.schoolPicker){
            print("run")
            return schoolArray.count
        } else if (pickerView == self.locationPicker){
            return locationArray.count
        } else if (pickerView == self.heightPicker) {
            return heightArray.count
        } else if (pickerView == self.bloodPicker) {
            return bloodArray.count
        } else if (pickerView == self.drinkPicker) {
            return drinkArray.count
        } else if (pickerView == self.religionPicker) {
            return religionArray.count
        } else if (pickerView == self.MbodyPicker && self.sex == false) {
            return MbodyArray.count
        } else if (pickerView == self.WbodyPicker && self.sex == true) {
            return WbodyArray.count
        } else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(pickerView == self.schoolPicker){
            return schoolArray[row]
        } else if (pickerView == self.locationPicker){
            return locationArray[row]
        } else if (pickerView == self.heightPicker) {
            return String(describing: heightArray[row])
        } else if (pickerView == self.bloodPicker) {
            return bloodArray[row]
        } else if (pickerView == self.drinkPicker) {
            return drinkArray[row]
        } else if (pickerView == self.religionPicker) {
            return religionArray[row]
        } else if (pickerView == self.MbodyPicker && self.sex == false) {
            return MbodyArray[row]
        } else if (pickerView == self.WbodyPicker && self.sex == true) {
            return WbodyArray[row]
        } else {
            return "error"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(pickerView == self.schoolPicker){
            self.schoolTextfield.text = schoolArray[row]
        } else if (pickerView == self.locationPicker){
            self.locationTextfield.text = self.locationArray[row]
        } else if (pickerView == self.heightPicker) {
            self.heightTextfield.text = String(describing: heightArray[row]) + "cm"
        } else if (pickerView == self.bloodPicker) {
            self.bloodTextfield.text = bloodArray[row]
        } else if (pickerView == self.drinkPicker) {
            self.drinkTextfield.text = drinkArray[row]
        } else if (pickerView == self.religionPicker) {
            self.religionTextfield.text = religionArray[row]
        } else if (pickerView == self.MbodyPicker && sex == false) {
            self.bodyTextfield.text = MbodyArray[row]
        } else if (pickerView == self.WbodyPicker && sex == true) {
            self.bodyTextfield.text = WbodyArray[row]
        } else {
            return
        }
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
        if(cell.cellImg.image != UIImage(named : "defualt")!) {
            cell.CellLabel.isHidden = true
        } else {
            cell.cellImg.image = profilImg[indexPath.row]
        }
        
        return cell
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        if(picker == certificationPicker){
            certificationBtn.setBackgroundImage(chosenImage, for: .normal)
        }else if(picker == cellPicker){
            if let a = currentIndexPathrow {
                profilImg[a] = chosenImage
                print("run")
            }
        }
        dismiss(animated: true, completion: nil)
        uploadCollection.reloadData()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        if textField.text != "" {
            if textField == schoolTextfield {
                schoolCheck.backgroundColor = UIColor.green
            } else if textField == specialtyTextfield {
                specialtyCheck.backgroundColor = UIColor.green
            } else if textField == locationTextfield {
                locationCheck.backgroundColor = UIColor.green
            } else if textField == heightTextfield {
                heightCheck.backgroundColor = UIColor.green
            } else if textField == bloodTextfield {
                bloodCheck.backgroundColor = UIColor.green
            } else if textField == bodyTextfield {
                bodyCheck.backgroundColor = UIColor.green
            } else if textField == drinkTextfield {
                drinkCheck.backgroundColor = UIColor.green
            } else if textField == religionTextfield {
                religionCheck.backgroundColor = UIColor.green
            }
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let scrollPoint : CGPoint = CGPoint(x : 0, y: textField.frame.origin.y + 200)
        self.ScrollView.setContentOffset(scrollPoint, animated: true)
        
        if (textField == schoolTextfield){
            schoolTextfield.text = schoolArray[0]
        } else if (textField == locationTextfield) {
            locationTextfield.text = locationArray[0]
        } else if (textField == heightTextfield) {
            heightTextfield.text = String(heightArray[0]) + "cm"
        } else if (textField == bodyTextfield) {
            bodyTextfield.text = MbodyArray[0]
        } else if (textField == drinkTextfield) {
            drinkTextfield.text = drinkArray[0]
        } else if (textField == religionTextfield) {
            religionTextfield.text = religionArray[0]
        } else if (textField == bloodTextfield) {
            bloodTextfield.text = bloodArray[0]
        }
    }
    
    func doneClick() {
        self.view.endEditing(true)
    }
    
    @IBAction func gunBaRi(_ sender: Any) {
        gunBarICheck.backgroundColor = UIColor.green
    }
    
    @IBAction func smoke(_ sender: Any) {
        smokeCheck.backgroundColor = UIColor.green
    }
    
    func tapView() {
        self.view.endEditing(true)
    }
    
    @IBAction func nextBtn(_ sender: Any) {
        guard let next = self.storyboard?.instantiateViewController(withIdentifier: "STQAViewController") else {
            return
        }
        self.navigationController?.pushViewController(next, animated: true)
    }
    
    @IBAction func certificationAction(_ sender: Any) {
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
    
    func backAction() {
        let alert = UIAlertController(title: nil, message: "입력하신내용은 저장되지 않습니다. 되돌아가시겠습니까?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: {action in
            _ = self.navigationController?.popViewController(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}
