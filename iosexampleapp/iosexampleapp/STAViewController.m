//
//  STAViewController.m
//  iosexampleapp
//
//  Created by StartApp on 2/19/14.
//  Copyright (c) 2014 StartApp. All rights reserved.
//

#import "STAViewController.h"
#import "STAGdprViewController.h"


@interface STAViewController ()

@property (weak, nonatomic) IBOutlet UIView* bottomContainerView;
@property (weak, nonatomic) IBOutlet UIButton* btnFixedBannerSize;

@end


@implementation STAViewController

/*
 Initialize StartApp SDK with your appId
 */
- (void)initStartAppSDK {
    // initialize the SDK with your appID and devID
    STAStartAppSDK* sdk = [STAStartAppSDK sharedInstance];
    
    if (sdk.appID != nil) {
        // The sdk has already been initialized
        return;
    }
    
    sdk.appID = @"yourAppId";
    sdk.devID = @"yourDeveloperId";
    sdk.preferences = [STASDKPreferences prefrencesWithAge:22 andGender:STAGender_Male];
    
    // loading the StartApp Ad
    [startAppAd_autoLoad loadAdWithDelegate:self];
    
    /*
     load the StartApp auto position banner, banner size will be assigned automatically by  StartApp
     */
    if (startAppBanner_bottom == nil) {
        startAppBanner_bottom = [[STABannerView alloc] initWithSize:STA_AutoAdSize
                                                         autoOrigin:STAAdOrigin_Bottom
                                                           withView:self.bottomContainerView
                                                       withDelegate:nil];
        
        [self.bottomContainerView addSubview:startAppBanner_bottom];
    }
    
    /*
     load the StartApp fixed position banner - in (0, 200)
     */
    if (startAppBanner_fixed == nil) {
        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ) {
            float halfX = 0.5f * (self.view.bounds.size.width - 768);
            startAppBanner_fixed = [[STABannerView alloc] initWithSize:STA_PortraitAdSize_768x90
                                                                origin:CGPointMake(halfX, 350)
                                                              withView:self.view withDelegate:nil];
        } else {
            float halfX = 0.5f * (self.view.bounds.size.width - 320);
            startAppBanner_fixed = [[STABannerView alloc] initWithSize:STA_PortraitAdSize_320x50
                                                                origin:CGPointMake(halfX, 160)
                                                              withView:self.view withDelegate:nil];
        }
        
        [self.view addSubview:startAppBanner_fixed];
    }
}

/*
 Also we recomend to show a splash screen ad in your app
 */
- (void)showSplashAd {
    STAStartAppSDK* sdk = [STAStartAppSDK sharedInstance];
    
    STASplashPreferences* splashPreferences = [[STASplashPreferences alloc] init];
    splashPreferences.splashMode = STASplashModeTemplate;
    splashPreferences.splashTemplateTheme = STASplashTemplateThemeOcean;
    splashPreferences.splashLoadingIndicatorType = STASplashLoadingIndicatorTypeDots;
    splashPreferences.splashTemplateIconImageName = @"StartAppIcon";
    splashPreferences.splashTemplateAppName = @"StartApp Example App";
    
    [sdk showSplashAdWithPreferences:splashPreferences];
}

- (void)writePersonalizedAdsConsent:(BOOL)isGranted {
    [[STAStartAppSDK sharedInstance]
        setUserConsent:isGranted
        forConsentType:@"pas"
        withTimestamp:[[NSDate date] timeIntervalSince1970]];
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"gdpr_dialog_was_shown"];
}

- (void)initStartAppSdkIfGdprShown {
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"gdpr_dialog_was_shown"]) {
        return;
    }
    
    [self initStartAppSDK];
    [self showSplashAd];
}

- (void)initStartAppSdkIfGdprNotShown {
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"gdpr_dialog_was_shown"]) {
        return;
    }
    
    [self performSegueWithIdentifier:@"showGdprSegue" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender {
    STAGdprViewController* dst = segue.destinationViewController;
    if (![dst isMemberOfClass:[STAGdprViewController class]]) {
        return;
    }
    
    dst.completionHandler = ^(BOOL isGranted) {
        [self initStartAppSDK];
        [self writePersonalizedAdsConsent:isGranted];
    };
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.btnFixedBannerSize
        setTitle:UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad ? @"768x90" : @"320x50"
        forState:UIControlStateNormal];
    
    [self initStartAppSdkIfGdprShown];
    
    /*
     Init of the startapp interstitials
     */
    startAppAd_autoLoad = [[STAStartAppAd alloc] init];
    startAppAd_loadShow = [[STAStartAppAd alloc] init];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self initStartAppSdkIfGdprNotShown];
}

- (void)viewWillTransitionToSize:(CGSize)size
       withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    
    [startAppBanner_bottom viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [startAppBanner_fixed viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

// Tell the system It should autorotate
- (BOOL)shouldAutorotate {
    return YES && (startAppAd_loadShow.STAShouldAutoRotate || startAppAd_autoLoad.STAShouldAutoRotate);
}

#pragma mark ShowAd button click
- (IBAction)btnShowAdClick:(id)sender {
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
- (IBAction)btnLoadShowClick:(id)sender {
    // load StartApp ad with Automatic AdType and self view controller
    // as a delegation for callbacks
    [startAppAd_loadShow loadAdWithDelegate:self];
}

#pragma mark Banner Size methods
- (IBAction)btnAutoBannerSizeClick:(id)sender {
    [startAppBanner_bottom setSTABannerSize:STA_AutoAdSize];
}

- (IBAction)btn320x50BannerSizeClick:(id)sender {
    if (UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        [startAppBanner_bottom setSTABannerSize:STA_PortraitAdSize_768x90];
    } else {
        [startAppBanner_bottom setSTABannerSize:STA_PortraitAdSize_320x50];
    }
}

- (IBAction)btnMRecBannerSizeClick:(id)sender {
    [startAppBanner_bottom setSTABannerSize:STA_MRecAdSize_300x250];
}
- (IBAction)btnCoverBannerSizeClick:(id)sender {
    [startAppBanner_bottom setSTABannerSize:STA_CoverAdSize];
}


#pragma mark STADelegateProtocol methods
/*
 Implementation of the STADelegationProtocol.
 All methods here are optional and you can
 implement only the ones you need.
*/

// StartApp Ad loaded successfully
- (void)didLoadAd:(STAAbstractAd*)ad {
    NSLog(@"StartApp Ad had been loaded successfully");
    
    // Show the Ad
    if (startAppAd_loadShow == ad) {
        [startAppAd_loadShow showAd];
    }
}

// StartApp Ad failed to load
- (void)failedLoadAd:(STAAbstractAd*)ad withError:(NSError*)error {
    NSLog(@"StartApp Ad had failed to load");
}

// StartApp Ad is being displayed
- (void)didShowAd:(STAAbstractAd*)ad {
    NSLog(@"StartApp Ad is being displayed");
}

// StartApp Ad failed to display
- (void)failedShowAd:(STAAbstractAd*)ad withError:(NSError*)error {
    NSLog(@"StartApp Ad is failed to display");
    if (startAppAd_autoLoad == ad) {
        UIAlertController* alert = [UIAlertController
                                    alertControllerWithTitle:@"Can't show ad"
                                    message:@"Ad is not loaded yet, please try again"
                                    preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)didCloseAd:(STAAbstractAd*)ad {
    if (startAppAd_autoLoad == ad) {
        [startAppAd_autoLoad loadAdWithDelegate:self];
    }
}

@end
