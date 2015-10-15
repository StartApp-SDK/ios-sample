//
//  STANativeAdDetails.h
//  StartApp
//
//  Created by StartApp on 9/15/14.
//  Copyright (c) 2014 StartApp. All rights reserved.
//  SDK version 3.2.3

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



@interface STANativeAdDetails : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSNumber *rating;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) UIImage *imageBitmap;
@property (nonatomic, strong) NSString *category;
@property (nonatomic, strong) NSString *adId;



- (void) sendImpression;
- (void) sendClick;

@end
