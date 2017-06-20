//
//  FirstViewController.swift
//  Booze Tracker
//
//  Created by Paul Keller on 30/11/2015.
//  Copyright © 2015 Planet K Games. All rights reserved.
//

import UIKit
import iAd

class HomeViewController: UIViewController, ADBannerViewDelegate {

    //var bannerView: ADBannerView!
    var UIiAd: ADBannerView = ADBannerView()
    var defaults = UserDefaults.standard
    
    @IBOutlet var lastSession: UILabel!
    @IBOutlet var sessionAmount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //self.canDisplayBannerAds = true;
        
        //bannerView = ADBannerView(adType: .Banner)
        //bannerView.translatesAutoresizingMaskIntoConstraints = false
        //bannerView.delegate = self
        //bannerView.hidden = true
        //view.addSubview(bannerView)
        
        //let viewsDictionary = ["bannerView":bannerView]
        /*
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[bannerView]|", options: [], metrics: nil, views: viewsDictionary))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[bannerView]|", options: [], metrics: nil, views: viewsDictionary))
        */
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if (defaults.string(forKey: "SessionLocation") != nil && defaults.string(forKey: "SessionLocation") != "")
        {
            lastSession.text = defaults.string(forKey: "SessionLocation")
            sessionAmount.text = defaults.string(forKey: "SessionAmount")
        }
        else
        {
            lastSession.text = "No Saved Session Yet, Get Boozing!"
            sessionAmount.text = ""
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func appDelegate() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (defaults.bool(forKey: "isAdFree") == false) {
            UIiAd.delegate = self
            UIiAd = self.appDelegate().UIiAd
            UIiAd.frame = CGRect(x: 0, y: 21, width: 0, height: 0)
            view.addSubview(UIiAd)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if (defaults.bool(forKey: "isAdFree") == false) {
            UIiAd.delegate = nil
            UIiAd.removeFromSuperview()
        }
    }
    
    func bannerViewDidLoadAd(_ banner: ADBannerView!) {
        //UIiAd.hidden = false
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(1)
        UIiAd.alpha = 1
        UIView.commitAnimations()
    }
    
    func bannerView(_ banner: ADBannerView!, didFailToReceiveAdWithError error: Error!) {
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(1)
        UIiAd.alpha = 0
        UIView.commitAnimations()
        //UIiAd.hidden = true
    }
    

}

