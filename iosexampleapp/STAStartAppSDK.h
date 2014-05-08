//
//  StartAppSDK.h
//  StartAppAdSDK
//
//  Created by StartApp on 3/13/14.
//  Copyright (c) 2014 StartApp. All rights reserved.
//  SDK version 2.1.0

#import <Foundation/Foundation.h>


// STAAdPreferences holds params specific to an ad
@interface STASDKPreferences : NSObject
@property (nonatomic,assign) NSUInteger age;
typedef enum {
	STAGender_Undefined = 0,
	STAGender_Female = 1,
    STAGender_Male=2
} STAGender;
@property (nonatomic, assign) STAGender gender;
+ (instancetype)prefrencesWithAge:(NSUInteger)age andGender:(STAGender)gender;
@end



@interface STAStartAppSDK : NSObject

+ (STAStartAppSDK*) sharedInstance;
- (void) SDKInitialize:(NSString*)devID andAppID:(NSString*) appID;

@property (nonatomic, retain) NSString* appID;
@property (nonatomic, retain) NSString* devID;
@property (nonatomic, retain) STASDKPreferences* preferences;


@end
