//
//  STAViewController.h
//  iosexampleapp
//
//  Created by StartApp on 2/19/14.
//  Copyright (c) 2014 StartApp. All rights reserved.
//

#import <UIKit/UIKit.h>

/* Import of StartApp SDK header files */
#import "STAStartAppAd.h"
#import "STABannerSize.h"
#import "STABannerView.h"

/* Definition of the implementation of STADelegateProtocol */
@interface STAViewController : UIViewController <STADelegateProtocol>
{
    /*
     Declaration of STAStartAppAd which later on will be used
     for loading within the viewDidApear and displaying when
     clicking a button
    */
    STAStartAppAd *startAppAd_autoLoad;
    
    /*
     Declaration of STAStartAppAd which later on will be used
     for loading when user clicks on a button and showing the
     loaded ad when the ad was loaded with delegation
    */
    STAStartAppAd *startAppAd_loadShow;
    
    /*
     Declaration of StartApp Banner view with automatic positioning
     */
    STABannerView *startAppBanner_auto;
    
    /*
     Declaration of StartApp Banner view with fixed positioning and size
     */
    STABannerView *startAppBanner_fixed;
}

@end
