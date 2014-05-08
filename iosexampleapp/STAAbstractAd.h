//
//  STAAbstractAd.h
//  StartAppAdSDK
//
//  Copyright (c) 2013 StartApp. All rights reserved.
//  SDK version 2.1.0

#import <Foundation/Foundation.h>
@class STAAbstractAd; // << Forward declaration
@protocol STADelegateProtocol <NSObject>
@optional

- (void) didLoadAd:(STAAbstractAd*)ad;
- (void) failedLoadAd:(STAAbstractAd*)ad withError:(NSError *)error;
- (void) didShowAd:(STAAbstractAd*)ad;
- (void) failedShowAd:(STAAbstractAd*)ad withError:(NSError *)error;
- (void) didCloseAd:(STAAbstractAd*)ad;

@end

// STAAdPreferences holds params specific to an ad
@interface STAAdPreferences : NSObject
@property (nonatomic,assign) double latitude;
@property (nonatomic, assign) double longitude;
+ (instancetype)prefrencesWithLatitude:(double) latitude andLongitude:(double)longitude;
@end


@interface STAAbstractAd : NSObject

@property (nonatomic, retain) STAAdPreferences *preferences;

- (BOOL) isReady;   // always check if ready before calling showAd

@end
