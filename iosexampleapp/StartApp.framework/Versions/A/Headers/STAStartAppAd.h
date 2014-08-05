//
//  StartAppAd.h
//  StartAppAdSDK
//
//  Copyright (c) 2013 StartApp. All rights reserved.
//  SDK version 2.2.0

#import <UIKit/UIKit.h>
#import "STAAbstractAd.h"

/* StartAppAd enumeration */
typedef enum {
	STAAdType_FullScreen = 1,
    STAAdType_OfferWall = 2,
    STAAdType_Automatic = 3,
    STAAdType_AppWall = 4,
    STAAdType_Overlay = 5
} STAAdType;

@interface STAStartAppAd : STAAbstractAd

@property (nonatomic, assign) bool STAShouldAutoRotate;
@property STAAdType startAppAdType;

- (id) init;

- (void) loadAd;
- (void) loadAdWithAdPreferences:(STAAdPreferences*) adPrefs;
- (void) loadAdWithDelegate:(id<STADelegateProtocol>) delegate;
- (void) loadAdWithDelegate:(id<STADelegateProtocol>) delegate withAdPreferences:(STAAdPreferences*) adPrefs;

- (void) loadAd:(STAAdType) adType;
- (void) loadAd:(STAAdType) adType withAdPreferences:(STAAdPreferences*) adPrefs;
- (void) loadAd:(STAAdType) adType withDelegate:(id<STADelegateProtocol>) delegate;

- (void) loadAd:(STAAdType) adType withDelegate:(id<STADelegateProtocol>) delegate withAdPreferences:(STAAdPreferences*) adPrefs;
- (void) showAd;

// initWithAppID is depreceted, will be removed in future SDKs, please use StartAppSDK instead.
+ (void) initWithAppId: (NSString*)applicationId developerId:(NSString*)developerId __attribute__((deprecated));


- (BOOL) isReady;

@end


