//
//  STSMSConfrimViewController.swift
//  st_ring
//
//  Created by euisuk_lee on 2017. 9. 18..
//  Copyright © 2017년 EuiSuk_Lee. All rights reserved.
//

import UIKit

class STSMSConfrimViewController: UIViewController{

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
