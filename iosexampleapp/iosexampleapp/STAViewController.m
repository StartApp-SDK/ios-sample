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
    [startAppAd_autoLoad loadAdWithDelegate:self];
    
    /*
     load the StartApp auto position banner, banner size will be assigned automatically by  StartApp
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
        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
        {
            startAppBanner_fixed = [[STABannerView alloc] initWithSize:STA_PortraitAdSize_768x90
                                                                origin:CGPointMake(0,300)
                                                              withView:self.view withDelegate:nil];
        } else {
            startAppBanner_fixed = [[STABannerView alloc] initWithSize:STA_PortraitAdSize_320x50
                                                                origin:CGPointMake(0,200)
                                                              withView:self.view withDelegate:nil];
        }

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

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

// Tell the system It should autorotate
- (BOOL) shouldAutorotate{
    return YES && (startAppAd_loadShow.STAShouldAutoRotate || startAppAd_autoLoad.STAShouldAutoRotate);
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
    [startAppAd_loadShow loadAdWithDelegate:self];
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
    if (startAppAd_loadShow == ad) {
        [startAppAd_loadShow showAd];
    }
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
    if (startAppAd_autoLoad == ad) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Can't show ad" message:@"Ad is not loaded yet, please try again" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
}

- (void) didCloseAd:(STAAbstractAd*)ad {
    if (startAppAd_autoLoad == ad) {
        [startAppAd_autoLoad loadAdWithDelegate:self];
    }
}

@end
