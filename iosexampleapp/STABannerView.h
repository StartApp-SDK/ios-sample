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
    - (id) initWithSize:(STABannerSize) size origin:(CGPoint) origin withView: (UIView*) view withDelegate:(id <STABannerDelegagteProtocol> ) bannerDelegate;
    - (id) initWithSize:(STABannerSize) size autoOrigin:(STAAdOrigin) origin withView: (UIView*) view withDelegate:(id <STABannerDelegagteProtocol> ) bannerDelegate;

    - (void)setSTABannerSize:(STABannerSize) size;

    - (void)setOrigin:(CGPoint) origin;

    - (void)setSTAAutoOrigin:(STAAdOrigin)origin;

    - (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation;

    -(void)addSTABannerToCell:(UITableViewCell *)cell withIndexPath:(NSIndexPath *)indexPath atIntexPathSection:(int)section repeatEach:(int)each;
    -(void)addSTABannerToCell:(UITableViewCell *)cell withIndexPath:(NSIndexPath *)indexPath atIntexPathSection:(int)section;

    -(void)addSTABannerToCell:(UITableViewCell *)cell withIndexPath:(NSIndexPath *)indexPath atIntexPathRow:(int)row repeatEach:(int)each;
    -(void)addSTABannerToCell:(UITableViewCell *)cell withIndexPath:(NSIndexPath *)indexPath atIntexPathRow:(int)row;
@end
