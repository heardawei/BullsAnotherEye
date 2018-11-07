//
//  AboutViewController.swift
//  BullsAnotherEye
//
//  Created by 李大伟 on 2018/11/6.
//  Copyright © 2018年 李大伟. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    
    @IBOutlet var webView: UIWebView!
    
    @IBAction func close() {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = Bundle.main.url(forResource: "bulls_another_eye", withExtension: "html") {
            if let htmlData = try? Data(contentsOf: url) {
                let baseURL = URL(fileURLWithPath: Bundle.main.bundlePath)
                webView.load(htmlData, mimeType: "text/html",textEncodingName: "UTF-8",baseURL: baseURL)
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
