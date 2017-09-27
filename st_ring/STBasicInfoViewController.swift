//
//  STBasicInfoViewController.swift
//  st_ring
//
//  Created by euisuk_lee on 2017. 9. 18..
//  Copyright © 2017년 EuiSuk_Lee. All rights reserved.
//

import UIKit

class STBasicInfoViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource,UITextFieldDelegate {
    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var ContentsView: UIView!
    @IBOutlet weak var progressImg: UIImageView!
    @IBOutlet weak var gunBariLabel: UILabel!
    @IBOutlet weak var gunBarI: UISegmentedControl!
    @IBOutlet weak var schoolTextfield: selectTextField!
    @IBOutlet weak var schoolLabel: UILabel!
    @IBOutlet weak var schoolGuide: UILabel!
    @IBOutlet weak var specialtyLabel: UILabel!
    @IBOutlet weak var specialtyTextfield: UITextField!
    @IBOutlet weak var specialtyGuide: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var locationTextfield: selectTextField!
    @IBOutlet weak var locationGuide: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var heightTextfield: selectTextField!
    @IBOutlet weak var heightGuide: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var bodyTextfield: selectTextField!
    @IBOutlet weak var bodyGuide: UILabel!
    @IBOutlet weak var smokeLabel: UILabel!
    @IBOutlet weak var smokeSegmented: UISegmentedControl!
    @IBOutlet weak var drinkLabel: UILabel!
    @IBOutlet weak var drinkTextfield: selectTextField!
    @IBOutlet weak var drinkGuide: UILabel!
    @IBOutlet weak var religionLabel: UILabel!
    @IBOutlet weak var religionTextfield: selectTextField!
    @IBOutlet weak var religionGuide: UILabel!
    @IBOutlet weak var bloodLabel: UILabel!
    @IBOutlet weak var bloodTextfield: selectTextField!
    @IBOutlet weak var bloodGuide: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    
    let schoolArray = ["인서울상위", "인서울4년제", "수도권4년제", "4년제", "전문대", "해외대학", "고졸"]
    let locationArray = ["서울", "부산", "인천", "광주", "울산", "대전", "대구", "경기", "강원", "경남", "경북", "충북", "충남", "전북", "전남"]
    let heightArray:[Int] = Array(140...200)
    let bloodArray = ["A", "B", "O", "AB"]
    let MbodyArray = ["마름", "슬림", "보통", "근육질", "통통한"]
    let WbodyArray = ["마름", "슬림", "보통", "글래머", "통통한"]
    let drinkArray = ["마시지 않음", "적당히 마심", "술자리를 즐김"]
    let religionArray = ["없음", "기독교", "불교", "천주교", "기타"]

    var defualtPicker = UIPickerView()
    var schoolPicker = UIPickerView()
    var locationPicker = UIPickerView()
    var heightPicker = UIPickerView()
    var bloodPicker = UIPickerView()
    var drinkPicker = UIPickerView()
    var religionPicker = UIPickerView()
    var MbodyPicker = UIPickerView()
    var WbodyPicker = UIPickerView()
    let toolBar = UIToolbar()
    
    var nextBtnYLocation:CGPoint!
    
    var sex = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(STBasicInfoViewController.tapView))
        tap.delegate = self as? UIGestureRecognizerDelegate
        self.view.addGestureRecognizer(tap)
        nextBtn.isEnabled = true
        nextBtn.backgroundColor = UIColor.lightGray
        
        schoolPicker.delegate = self
        locationPicker.delegate = self
        heightPicker.delegate = self
        bloodPicker.delegate = self
        drinkPicker.delegate = self
        religionPicker.delegate = self
        MbodyPicker.delegate = self
        WbodyPicker.delegate = self
        
        
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
            let womenConst1 = NSLayoutConstraint(item: schoolLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: progressImg, attribute:NSLayoutAttribute.top, multiplier: 1, constant: CGFloat(50))
            self.view.addConstraint(womenConst1)
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
        specialtyTextfield.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        let textFieldArray = [schoolTextfield, specialtyTextfield, locationTextfield, heightTextfield, bodyTextfield, drinkTextfield, religionTextfield, bloodTextfield]
        var checker : Int = 0
        
        if (textField == specialtyTextfield) {
            if(textField.text == "") {
                specialtyGuide.textColor = UIColor.red
                specialtyGuide.isHidden = false
            }
        }
        
        for i in textFieldArray {
            if(i?.text == ""){
                checker += 1
            }
        }
        
        if(self.sex == false){
            if(gunBarI.isSelected == true) {
                checker += 1
            }
        }
        
        if (smokeSegmented.isSelected == true) {
            checker += 1
        }
        
        if (checker == 0) {
            self.nextBtn.isEnabled = true
            self.nextBtn.backgroundColor = UIColor.black
        }
        print(checker)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if(textField != schoolTextfield && textField != specialtyTextfield) {
            let scrollPoint : CGPoint = CGPoint(x : 0, y: textField.frame.origin.y - 200)
            self.ScrollView.setContentOffset(scrollPoint, animated: true)
        }
        
        if (textField == schoolTextfield){
            schoolGuide.isHidden = true
            schoolTextfield.text = schoolArray[0]
        } else if (textField == specialtyTextfield) {
            specialtyGuide.isHidden = true
        } else if (textField == locationTextfield) {
            locationGuide.isHidden = true
            locationTextfield.text = locationArray[0]
        } else if (textField == heightTextfield) {
            heightGuide.isHidden = true
            heightTextfield.text = String(heightArray[0]) + "cm"
        } else if (textField == bodyTextfield) {
            bodyGuide.isHidden = true
            bodyTextfield.text = MbodyArray[0]
        } else if (textField == drinkTextfield) {
            drinkGuide.isHidden = true
            drinkTextfield.text = drinkArray[0]
        } else if (textField == religionTextfield) {
            religionGuide.isHidden = true
            religionTextfield.text = religionArray[0]
        } else if (textField == bloodTextfield) {
            bloodGuide.isHidden = true
            bloodTextfield.text = bloodArray[0]
        }
    }
    
    func doneClick() {
        self.view.endEditing(true)
    }
    
    @IBAction func gunBaRi(_ sender: UISegmentedControl) {
        switch  gunBarI.selectedSegmentIndex {
        case 0:
            print("군필")
        case 1:
            print("미필")
        case 2:
            print("해당없음")
        default:
            print("error")
        }
    }
    
    @IBAction func smoke(_ sender: UISegmentedControl) {
        switch smokeSegmented.selectedSegmentIndex {
        case 0:
            print("비흡연")
        case 1:
            print("흡연")
        default:
            print("error")
        }
    }
    
    func tapView() {
        self.view.endEditing(true)
    }
    
    @IBAction func nextBtn(_ sender: Any) {
        guard let next = self.storyboard?.instantiateViewController(withIdentifier: "STImgUploadViewController") else {
            return
        }
        self.navigationController?.pushViewController(next, animated: true)
    }
}
