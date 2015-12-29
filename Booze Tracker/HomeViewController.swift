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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func appDelegate() -> AppDelegate {
        return UIApplication.sharedApplication().delegate as! AppDelegate
    }
    
    override func viewDidAppear(animated: Bool) {
        UIiAd.delegate = self
        UIiAd = self.appDelegate().UIiAd
        UIiAd.frame = CGRectMake(0, 21, 0, 0)
        view.addSubview(UIiAd)
    }
    
    override func viewWillDisappear(animated: Bool) {
        UIiAd.delegate = nil
        UIiAd.removeFromSuperview()
    }
    
    func bannerViewDidLoadAd(banner: ADBannerView!) {
        //UIiAd.hidden = false
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(1)
        UIiAd.alpha = 1
        UIView.commitAnimations()
    }
    
    func bannerView(banner: ADBannerView!, didFailToReceiveAdWithError error: NSError!) {
        //bannerView.hidden = true
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(1)
        UIiAd.alpha = 0
        UIView.commitAnimations()
    }
    

}

