//
//  STStartViewController.swift
//  st_ring
//
//  Created by EuiSuk_Lee on 2017. 8. 28..
//  Copyright © 2017년 EuiSuk_Lee. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore



class STStartViewController: UIViewController {
    @IBOutlet weak var StartLogoImg: UIImageView!
    @IBOutlet weak var agreeLabel: UILabel!
    @IBOutlet weak var emailJoin: UIButton!
    @IBOutlet weak var LoginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let range1 = NSMakeRange(21, 5)
        let range2 = NSMakeRange(29, 8)
        let attribute : [String:Any] = [
            NSUnderlineStyleAttributeName : NSUnderlineStyle.styleThick.rawValue,
            NSUnderlineColorAttributeName : UIColor.black,
            NSLinkAttributeName : NSURL(string: "http://www.google.com")!
        ]
        
        let agreeLabelText = "가입하기 또는 로그인 버튼을 누르면 \n이용 약관 및 개인정보취급방침에 동의하신 것이 됩니다."
        let attributedText = NSMutableAttributedString(string: agreeLabelText, attributes: nil)
        //let tapGesture = UITapGestureRecognizer(target: self, action: Selector("agreeLinkTap"))
        attributedText.addAttributes(attribute, range: range1)
        attributedText.addAttributes(attribute, range: range2)
        
        agreeLabel.textAlignment = .center
        agreeLabel.attributedText = attributedText
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func FBJoing(_ sender: Any) {
        let loginManager = LoginManager()
        
        loginManager.logIn([ .publicProfile ], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success( _, _, _):
                print("Logged in!")
            }
        }
    }
    
    @IBAction func KakaoJoin(_ sender: Any) {
        let session = KOSession.shared()
        
        if let s = session {
            if s.isOpen(){
                s.close()
            }
            s.open(completionHandler: { (error) in
                if error == nil {
                    print("No error")
                    
                    if s.isOpen(){
                        print("Success")
                    }else {
                        print("Faild")
                    }
                }
                else {
                    print("Error login : \(error!)")
                }
            })
        }
        else {
            print("Something wrong")
        }
    }
    
    func agreeLinkTap(sender: UITapGestureRecognizer){
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
