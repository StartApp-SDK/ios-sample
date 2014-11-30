//
//  STANativeViewController.m
//  iosexampleapp
//
//  Created by Nadav on 11/27/14.
//  Copyright (c) 2014 StartApp. All rights reserved.
//

#import "STANativeViewController.h"

@interface STANativeViewController ()


@property (weak, nonatomic) IBOutlet UIButton *showAdButton;
@property (weak, nonatomic) IBOutlet UILabel *adTitle;
@property (weak, nonatomic) IBOutlet UIImageView *adImageView;
@property (weak, nonatomic) IBOutlet UIButton *clickAdButton;

@end


@implementation STANativeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Initialize the ad
    startAppNativeAd = [[STAStartAppNativeAd alloc] init];
}

- (IBAction)loadAd:(id)sender {
    // Loading the ad
    STANativeAdPreferences *pref = [[STANativeAdPreferences alloc]init];
    pref.adsNumber = 1; // Request only one ad
    pref.autoBitmapDownload = YES; // Do not download image
    pref.bitmapSize = SIZE_150X150;
    [startAppNativeAd loadAdWithDelegate:self withNativeAdPreferences:pref];
}

// Delegate method to know when the ad finished loading
- (void)didLoadAd:(STAAbstractAd *)ad {
    self.showAdButton.hidden = NO;
        self.adImageView.hidden = NO;    
}

- (void)failedLoadAd:(STAAbstractAd *)ad withError:(NSError *)error {
    // Failed loading the ad, do something else.
}

- (IBAction)showAd:(id)sender {
    // Show the ad only if it has been loaded
    if (startAppNativeAd.adIsLoaded) {
        // Take the first ad, which in default can be only one.
        adDetails = [startAppNativeAd.adsDetails objectAtIndex:0];
        
        // Send the impression
        [adDetails sendImpression];
        self.clickAdButton.hidden = NO;
        
        self.adTitle.text = adDetails.title;
        self.adTitle.hidden = NO;
        self.adImageView.image = adDetails.imageBitmap;
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Ad is not loaded" message:@"Native ad hasn't been loaded so we don't need to show the ad" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alertView.tag = 2;
        [alertView show];
    }
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (IBAction)clickAd:(id)sender {
    // Send the click.
    [adDetails sendClick];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
