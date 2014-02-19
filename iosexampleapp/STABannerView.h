//
//  StartAppBannerView.h
//  StartAppAdSDK
//
//  Created by StartApp on 11/13/13.
//  Copyright (c) 2013 StartApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STABannerSize.h"

@protocol STABannerDelegagteProtocol <NSObject>
@optional
- (void) didDisplayBannerAd;
- (void) failedLoadBannerAd:(NSError *)error;
- (void) didClickBannerAd;
@end

typedef enum {
	STAAdOrigin_Top = 1,
    STAAdOrigin_Bottom = 2,
} STAAdOrigin;

@interface STABannerView : UIView <UIWebViewDelegate>

- (id) initWithIds:(NSString *) applicationId publisherId:(NSString *) publisherId size:(STABannerSize) size origin:(CGPoint) origin withView: (UIView*) view
      withDelegate:(id <STABannerDelegagteProtocol> ) bannerDelegate;

- (id) initWithIds:(NSString *) applicationId publisherId:(NSString *) publisherId size:(STABannerSize) size autoOrigin:(STAAdOrigin) origin withView: (UIView*) view
      withDelegate:(id <STABannerDelegagteProtocol> ) bannerDelegate;

- (void)setSTABannerSize:(STABannerSize) size;

- (void)setOrigin:(CGPoint) origin;

- (void)setSTAAutoOrigin:(STAAdOrigin)origin;

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation;


@end
