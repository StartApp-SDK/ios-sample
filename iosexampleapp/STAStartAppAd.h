//
//  StartAppAd.h
//  StartAppAdSDK
//
//  Copyright (c) 2013 StartApp. All rights reserved.
//

#import <UIKit/UIKit.h>


/*
 * StartAppAd enumeration
 *
 * StartAppAdType_FullScreen- Full Screen ad
 */
typedef enum {
	STAAdType_FullScreen = 1,
    STAAdType_OfferWall = 2,
    STAAdType_Automatic = 3,
    STAAdType_AppWall = 4,
} STAAdType;

@protocol STADelegateProtocol <NSObject>
@optional

- (void) didLoadAd;
- (void) failedLoadAd:(NSError *)error;
- (void) didShowAd;
- (void) failedShowAd:(NSError *)error;

@end


@interface STAStartAppAd : NSObject


@property (readwrite,readwrite) bool STAShouldAutoRotate;

- (id) initWithAppId:(NSString *)applicationId publisherId:(NSString *)publisherId;
- (void) loadAd;
- (void) loadAd:(STAAdType) adType;
- (void) loadAd:(STAAdType) adType withDelegate:(id<STADelegateProtocol>)delegate;
- (void) loadAd:(STAAdType) adType withDelegate:(id<STADelegateProtocol>) delegate withParams:(NSMutableDictionary*)optionalParams;

- (void) showAd;

- (BOOL) isReady;



@end


