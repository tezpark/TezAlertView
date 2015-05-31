//
//  ViewController.m
//  TezAlertViewExample
//
//  Created by Taesun Park on 2015. 5. 27..
//  Copyright (c) 2015년 TezLab. All rights reserved.
//

#import "ViewController.h"

#import "TezAlertView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor blackColor]];
}

- (void)viewDidAppear:(BOOL)animated {
    
    UIButton* tmoBtn = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width-250)/2, 100, 250, 30)];
    [tmoBtn setTitle:@"Title & message | One Button" forState:UIControlStateNormal];
    [tmoBtn setBackgroundColor:[UIColor lightGrayColor]];
    [tmoBtn addTarget:self action:@selector(onClickTitleMessageOneButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tmoBtn];
    
    UIButton* tooBtn = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width-250)/2, CGRectGetMaxY(tmoBtn.frame)+50, 250, 30)];
    [tooBtn setTitle:@"Title only | One Button" forState:UIControlStateNormal];
    [tooBtn setBackgroundColor:[UIColor lightGrayColor]];
    [tooBtn addTarget:self action:@selector(onClickTitleOnlyOneButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tooBtn];
    
    UIButton* mooBtn = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width-250)/2, CGRectGetMaxY(tooBtn.frame)+50, 250, 30)];
    [mooBtn setTitle:@"Message only | One Button" forState:UIControlStateNormal];
    [mooBtn setBackgroundColor:[UIColor lightGrayColor]];
    [mooBtn addTarget:self action:@selector(onClickMessageOnlyOneButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mooBtn];
    
    
    UIButton* tmtBtn = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width-250)/2, CGRectGetMaxY(mooBtn.frame)+50, 250, 30)];
    [tmtBtn setTitle:@"Title & message | Two Button" forState:UIControlStateNormal];
    [tmtBtn setBackgroundColor:[UIColor lightGrayColor]];
    [tmtBtn addTarget:self action:@selector(onClickTitleMessage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tmtBtn];

    UIButton* ottBtn = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width-250)/2, CGRectGetMaxY(tmtBtn.frame)+50, 250, 30)];
    [ottBtn setTitle:@"Title only | Two Button" forState:UIControlStateNormal];
    [ottBtn setBackgroundColor:[UIColor lightGrayColor]];
    [ottBtn addTarget:self action:@selector(onClickTitleOnly) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ottBtn];

    UIButton* omtBtn = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width-250)/2, CGRectGetMaxY(ottBtn.frame)+50, 250, 30)];
    [omtBtn setTitle:@"Message only | Two Button" forState:UIControlStateNormal];
    [omtBtn setBackgroundColor:[UIColor lightGrayColor]];
    [omtBtn addTarget:self action:@selector(onClickMessageOnly) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:omtBtn];
}

#pragma mark - OnClick actions
- (void)onClickTitleMessageOneButton {
    [[TezAlertView sharedInstance] showAlertViewWithTitle:@"This is Title!"
                                                  message:@"I am a message"
                                       dismissButtonTitle:@"Ok"
                                             dismissBlock:^{
                                                 NSLog(@"Dismiss Block!");
                                             }];
}

- (void)onClickTitleOnlyOneButton {
    [[TezAlertView sharedInstance] showAlertViewWithMessage:@"I am a message"
                                       dismissButtonTitle:@"Ok"
                                             dismissBlock:^{
                                                 NSLog(@"Dismiss Block!");
                                             }];
}

- (void)onClickMessageOnlyOneButton {
    [[TezAlertView sharedInstance] showAlertViewWithTitle:nil
                                                  message:@"I am a message"
                                       dismissButtonTitle:@"Ok"
                                             dismissBlock:^{
                                                 NSLog(@"Dismiss Block!");
                                             }];
}

- (void)onClickTitleMessage {
    [[TezAlertView sharedInstance] showAlertViewWithTitle:@"This is Title!"
                                                  message:@"I am a message"
                                       dismissButtonTitle:@"Ok"
                                        cancelButtonTitle:@"Close"
                                             dismissBlock:^{
                                                 NSLog(@"Dismiss Block!");
                                             } cancelBlock:^{
                                                 NSLog(@"Cancel Block!");
                                             }];
}

- (void)onClickTitleOnly {
    [[TezAlertView sharedInstance] showAlertViewWithTitle:@"This is Title!"
                                       dismissButtonTitle:@"Ok"
                                        cancelButtonTitle:@"Close"
                                             dismissBlock:^{
                                                 NSLog(@"Dismiss Block!");
                                             } cancelBlock:^{
                                                 NSLog(@"Cancel Block!");
                                             }];
}

- (void)onClickMessageOnly {
    [[TezAlertView sharedInstance] showAlertViewWithMessage:@"I am a message"
                                       dismissButtonTitle:@"Ok"
                                        cancelButtonTitle:@"Close"
                                             dismissBlock:^{
                                                 NSLog(@"Dismiss Block!");
                                             } cancelBlock:^{
                                                 NSLog(@"Cancel Block!");
                                             }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
