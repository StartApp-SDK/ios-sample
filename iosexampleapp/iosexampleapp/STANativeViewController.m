//
//  STANativeViewController.m
//  iosexampleapp
//
//  Created by Nadav on 11/27/14.
//  Copyright (c) 2014 StartApp. All rights reserved.
//

#import "STANativeViewController.h"

@interface STANativeViewController ()


@property (nonatomic, retain)  IBOutlet UITableView *myTableView;

@end


@implementation STANativeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Initialize the ad
    startAppNativeAd = [[STAStartAppNativeAd alloc] init];
}

-(void)viewDidAppear:(BOOL)animated{
    //Adjust the tableView frame to fit the screen size
    CGRect frame = self.view.frame;
    frame.origin.y = 66;
    frame.size.height = frame.size.height - 66;
    self.myTableView.frame = frame;
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
- (void)didLoadAd:(STAAbstractAd *)ad {
    self.myTableView.hidden = NO;
    //Reload tableView data
    [self.myTableView reloadData];
}

- (void)failedLoadAd:(STAAbstractAd *)ad withError:(NSError *)error {
    // Failed loading the ad, do something else.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

// Customize the number of rows in the table view.

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //Set the number of rows
    return startAppNativeAd.adsDetails.count;
    
}

// Customize the appearance of table view cells.

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CustomCell";
    UITableViewCell *cell=nil;
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)  {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    
    //Set cell's text and image from the native ad adDetails
    STANativeAdDetails *adDetails = [startAppNativeAd.adsDetails objectAtIndex:indexPath.row];
    cell.textLabel.text=[[startAppNativeAd.adsDetails objectAtIndex:indexPath.row] title];
    cell.textLabel.numberOfLines= 2;
    cell.imageView.image=[[startAppNativeAd.adsDetails objectAtIndex:indexPath.row] imageBitmap];
    
    //Send impression
    [adDetails sendImpression];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //Send click
    STANativeAdDetails *adDetails = [startAppNativeAd.adsDetails objectAtIndex:indexPath.row];
    [adDetails sendClick];
}



- (BOOL)shouldAutorotate {
    return NO;
}


- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
