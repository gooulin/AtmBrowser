//
//  ViewController.m
//  ATMBrowser
//
//  Created by goolu on 2016/11/12.
//  Copyright © 2016年 goolu. All rights reserved.
//

#import "ViewController.h"
#import <SafariServices/SafariServices.h>
#import "InterstitialAdViewController.h"
#import "BannerAdViewController.h"

@interface ViewController ()<SFSafariViewControllerDelegate>
//Containers to hold the controller views, this gives us less layout and more control over transitions
@property (nonatomic, strong) UIView *browserContainer;
@property (nonatomic, strong) UIView *interstitialContainer;
@property (nonatomic, strong) BannerAdViewController *bannerAdViewController;

@end

@implementation ViewController

- (void) loadView
{
    UIView *view = [UIView new];
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    view.backgroundColor = [UIColor blueColor];
    
    //Set up containers and their constraints
    self.browserContainer = [UIView new];
    self.browserContainer.backgroundColor = [UIColor greenColor];
    [view addSubview:self.browserContainer];
    self.browserContainer.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    self.interstitialContainer = [UIView new];
    [self.interstitialContainer setTranslatesAutoresizingMaskIntoConstraints:NO];
    //self.interstitialContainer.backgroundColor = [UIColor redColor];
    [view addSubview:self.interstitialContainer];
    
    // Container view fills out entire root view.

    [view addConstraint:[NSLayoutConstraint constraintWithItem:self.interstitialContainer attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:self.interstitialContainer attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTop multiplier:1 constant:65]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:self.interstitialContainer attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:self.interstitialContainer attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    
    self.view = view;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    SFSafariViewController *browser_vc = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:@"http://www.mobile01.com/"]];
    UIView *toView = browser_vc.view;
    [toView setTranslatesAutoresizingMaskIntoConstraints:YES];
    toView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    toView.frame = self.browserContainer.bounds;
    [self addChildViewController:browser_vc];
    [self.browserContainer addSubview:toView];
    [browser_vc didMoveToParentViewController:self];
    browser_vc.delegate = self;
    
    self.bannerAdViewController = [[BannerAdViewController alloc] init];
    UIView *toAdView = self.bannerAdViewController.view;
    [toAdView setTranslatesAutoresizingMaskIntoConstraints:YES];
    toAdView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    toAdView.frame = self.interstitialContainer.bounds;

    [self.interstitialContainer addSubview:toAdView];
    [self addChildViewController:self.bannerAdViewController];
    
    [self.bannerAdViewController didMoveToParentViewController:self];
    
}
- (void)safariViewControllerDidFinish:(SFSafariViewController *)controller
{
    InterstitialAdViewController *i_vc = [[InterstitialAdViewController alloc] init];
    UIView *toAdView = i_vc.view;
    [toAdView setTranslatesAutoresizingMaskIntoConstraints:YES];
    toAdView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    toAdView.frame = self.interstitialContainer.bounds;
    //
    [self.interstitialContainer addSubview:toAdView];
    [self addChildViewController:i_vc];
}
- (void)safariViewController:(SFSafariViewController *)controller didCompleteInitialLoad:(BOOL)didLoadSuccessfully
{
    [self.bannerAdViewController.view removeFromSuperview];
    [self.bannerAdViewController removeFromParentViewController];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
