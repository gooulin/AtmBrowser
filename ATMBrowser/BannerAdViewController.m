//
//  bannerAdViewController.m
//  ATMBrowser
//
//  Created by goolu on 2016/11/13.
//  Copyright © 2016年 goolu. All rights reserved.
//

#import "bannerAdViewController.h"
#import <GoogleMobileAds/GADInterstitial.h>

@interface bannerAdViewController ()

@end

@implementation bannerAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    GADBannerView *bannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeMediumRectangle];
    bannerView.adUnitID = @"ca-app-pub-7448507710193235/8291501104";
    bannerView.frame = CGRectMake(self.view.frame.size.width/2 - 150,
                                  self.view.frame.size.height/2 - 125, 300, 250);
    bannerView.rootViewController = self;
    GADRequest *request = [GADRequest request];
    request.testDevices = @[ kGADSimulatorID ];
    [bannerView loadRequest:request];
    [self.view addSubview:bannerView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
