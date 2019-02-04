//
//  STANativeViewController.m
//  iosexampleapp
//
//  Created by StartApp on 11/27/14.
//  Copyright (c) 2014 StartApp. All rights reserved.
//

#import "STANativeViewController.h"

#define kAdCellsInterval    5

@interface STANativeViewController ()

@property (nonatomic, retain)  IBOutlet UITableView *myTableView;

@end


@implementation STANativeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Initialize the ad
    startAppNativeAd = [[STAStartAppNativeAd alloc] init];
}

- (IBAction)loadAd:(id)sender {
    // Loading the ad
    self.myTableView.hidden = YES;
    STANativeAdPreferences *pref = [[STANativeAdPreferences alloc]init];
    pref.adsNumber = 10; // Request 10
    pref.autoBitmapDownload = YES; // Do not download image
    pref.bitmapSize = SIZE_100X100;
    [startAppNativeAd loadAdWithDelegate:self withNativeAdPreferences:pref];
}

// Delegate method to know when the ad finished loading
- (void)didLoadAd:(STAAbstractAd*)ad {
    self.myTableView.hidden = NO;
    //Reload tableView data
    [self.myTableView reloadData];
}

- (void)failedLoadAd:(STAAbstractAd*)ad withError:(NSError*)error {
    // Failed loading the ad, do something else.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView {
    return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //Set the number of rows. Every 5th cell is cell with ad
    return startAppNativeAd.adsDetails.count * kAdCellsInterval;
    
}

// Customize the appearance of table view cells.
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {
    static NSString* regularCellIdentifier = @"RegularCell";
    static NSString* adCellIdentifier = @"AdCell";
    
    BOOL isAdCell = indexPath.row % kAdCellsInterval == 0;
    NSString *cellIdentifier = (isAdCell) ? adCellIdentifier : regularCellIdentifier;
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)  {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (isAdCell) {
        //Set cell's text and image from the native ad adDetails
        NSInteger adIndex = indexPath.row / kAdCellsInterval;
        STANativeAdDetails* adDetails = [startAppNativeAd.adsDetails objectAtIndex:adIndex];
        cell.textLabel.text = [adDetails title];
        cell.textLabel.numberOfLines = 2;
        cell.imageView.image = [adDetails imageBitmap];
        
        //Registering cell for automatic impression and click tracking
        [adDetails registerViewForImpressionAndClick:cell];
    }
    else {
        cell.textLabel.text = [NSString stringWithFormat:@"Regular cell at row = %ld", (long)indexPath.row];
    }
    
    return cell;
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
