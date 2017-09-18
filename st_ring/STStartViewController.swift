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
import TTTAttributedLabel



class STStartViewController: UIViewController,TTTAttributedLabelDelegate {
    @IBOutlet weak var StartLogoImg: UIImageView!
    @IBOutlet weak var emailJoin: UIButton!
    @IBOutlet weak var agreeLabel: TTTAttributedLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let range1 = NSMakeRange(21, 5)
        let range2 = NSMakeRange(29, 8)
        let agreeLabelText = "가입하기 또는 로그인 버튼을 누르면 \n이용 약관 및 개인정보취급방침에 동의하신 것이 됩니다."
        
        agreeLabel.text = agreeLabelText
        agreeLabel.textAlignment = .center
        agreeLabel.delegate = self
        agreeLabel.linkAttributes = [
            NSForegroundColorAttributeName : UIColor.black,
            NSUnderlineStyleAttributeName : NSUnderlineStyle.styleThick.rawValue,
            NSUnderlineColorAttributeName : UIColor.black
        ]
        agreeLabel.addLink(to: NSURL(string: "https://s.zigbang.com/agree/user-agreement-last.html") as URL!, with: range1)
        agreeLabel.addLink(to: NSURL(string: "https://s.zigbang.com/agree/user-privacy-last.html") as URL!, with: range2)
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
    
    public func attributedLabel(_ label: TTTAttributedLabel!, didSelectLinkWith url: URL!){
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    @IBAction func EmailJoin(_ sender: Any) {
        guard let EmailJoin = storyboard?.instantiateViewController(withIdentifier: "STJoinNavigationController") else {
            return
        }
        
        self.present(EmailJoin, animated: true, completion: nil)
    }
    
}
