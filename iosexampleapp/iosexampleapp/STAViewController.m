//
//  STAViewController.m
//  iosexampleapp
//
//  Created by StartApp on 2/19/14.
//  Copyright (c) 2014 StartApp. All rights reserved.
//

#import "STAViewController.h"

@interface STAViewController ()

@end

@implementation STAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /* 
     Init of the startapp interstitials
     NOTE: replace the ApplicationID and the PublisherID with your own IDs
     */
    startAppAd_autoLoad = [[STAStartAppAd alloc] init];
    startAppAd_loadShow = [[STAStartAppAd alloc] init];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // loading the StartApp Ad
    [startAppAd_autoLoad loadAd];
    
    /*
     load the StartApp auto position banner
     NOTE: replace the ApplicationID and the PublisherID with your own IDs
     */
    if (startAppBanner_auto == nil) {
        startAppBanner_auto = [[STABannerView alloc] initWithSize:STA_AutoAdSize
                                                     autoOrigin:STAAdOrigin_Bottom
                                                     withView:self.view withDelegate:nil];
        [self.view addSubview:startAppBanner_auto];
    }
    
    /*
     load the StartApp fixed position banner - in (0, 200)
     NOTE: replace the ApplicationID and the PublisherID with your own IDs
     */
    if (startAppBanner_fixed == nil) {
        startAppBanner_fixed = [[STABannerView alloc] initWithSize:STA_PortraitAdSize_320x50
                                                      origin:CGPointMake(0,200)
                                                      withView:self.view withDelegate:nil];
        [self.view addSubview:startAppBanner_fixed];
    }
}

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    
    // notify StartApp auto Banner orientation change
    [startAppBanner_auto didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    
    // notify StartApp fixed position Banner orientation change
    [startAppBanner_fixed didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation ];
}

#pragma mark ShowAd button click
- (IBAction)btnShowAdClick:(id)sender
{
    /*
     displaying StartApp ad.
     NOTE:  Since the loadAd method is async,
            it is possible that when calling the showAd method the
            ad hasn't been loaded yet.
            You can verify that by using the isReady method.
    */
    [startAppAd_autoLoad showAd];
}

#pragma mark Load and Show button click
- (IBAction)btnLoadShowClick:(id)sender
{
    // load StartApp ad with Automatic AdType and self view controller
    // as a delegation for callbacks
    [startAppAd_loadShow loadAd:STAAdType_Automatic withDelegate:self];
}

#pragma mark STADelegateProtocol methods
/*
 Implementation of the STADelegationProtocol.
 All methods here are optional and you can
 implement only the ones you need.
*/

// StartApp Ad loaded successfully
- (void) didLoadAd:(STAAbstractAd*)ad;
{
    NSLog(@"StartApp Ad had been loaded successfully");
    
    // Show the Ad
    [startAppAd_loadShow showAd];
}

// StartApp Ad failed to load
- (void) failedLoadAd:(STAAbstractAd*)ad withError:(NSError *)error;
{
    NSLog(@"StartApp Ad had failed to load");
}

// StartApp Ad is being displayed
- (void) didShowAd:(STAAbstractAd*)ad;
{
    NSLog(@"StartApp Ad is being displayed");
}

// StartApp Ad failed to display
- (void) failedShowAd:(STAAbstractAd*)ad withError:(NSError *)error;
{
    NSLog(@"StartApp Ad is failed to display");
}

@end
