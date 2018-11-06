//
//  STAGdprViewController.m
//  iosexampleapp
//
//  Created by tto on 11/5/18.
//  Copyright © 2018 StartApp. All rights reserved.
//

#import "STAGdprViewController.h"


@implementation STAGdprViewController

- (IBAction)onOkPressed:(UIButton*)sender {
    if (self.completionHandler) {
        self.completionHandler(true);
    }
    
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)onCancelPressed:(UIButton*)sender {
    if (self.completionHandler) {
        self.completionHandler(false);
    }
    
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
