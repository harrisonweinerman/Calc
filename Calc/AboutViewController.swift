//
//  AboutViewController.swift
//  Calc
//
//  Created by Harrison Weinerman on 4/20/15.
//  Copyright (c) 2015 Harrison Weinerman. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func twitter(sender: AnyObject) {
        var url : String!
        
        if UIApplication.sharedApplication().canOpenURL(NSURL(string: "twitter://")!) {
            url = "twitter://user?screen_name=hrrsn"
        }
        else {
            url = "twitter.com/hrrsn"
        }
        openURL(url)
    }
    
    @IBAction func email(sender: AnyObject) {
        openURL("mailto://h@rrison.co")
    }
    
    @IBAction func site(sender: AnyObject) {
        openURL("http://harrison.click")
    }
    
    func openURL(url : String){
        UIApplication.sharedApplication().openURL(NSURL(string: url)!)

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
