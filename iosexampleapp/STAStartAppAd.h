//
//  StartAppAd.h
//  StartAppAdSDK
//
//  Copyright (c) 2013 StartApp. All rights reserved.
//

#import <UIKit/UIKit.h>


/*
 * StartAppAd enumeration
 */
typedef enum {
	STAAdType_FullScreen = 1,
    STAAdType_OfferWall = 2,
    STAAdType_Automatic = 3,
    STAAdType_AppWall = 4,
    STAAdType_Overlay = 5
} STAAdType;

@protocol STADelegateProtocol <NSObject>
@optional

- (void) didLoadAd;
- (void) failedLoadAd:(NSError *)error;
- (void) didShowAd;
- (void) failedShowAd:(NSError *)error;
- (void) didCloseAd;

@end

@interface STAAppDetails : NSObject
    @property (nonatomic, retain) NSString *appID;
    @property (nonatomic, retain) NSString *devID;
@end

@interface STAStartAppAd : NSObject
    @property (readwrite,readwrite) bool STAShouldAutoRotate;
    + (void) initWithAppId: (NSString*)applicationId developerId:(NSString*)developerId;
    + (STAAppDetails*) getAppDetails;
    - (id) init;
    - (void) loadAd;
    - (void) loadAd:(STAAdType) adType;
    - (void) loadAd:(STAAdType) adType withDelegate:(id<STADelegateProtocol>)delegate;
    - (void) loadAd:(STAAdType) adType withDelegate:(id<STADelegateProtocol>) delegate withParams:(NSMutableDictionary*)optionalParams;
    - (void) showAd;
    - (BOOL) isReady;
@end



