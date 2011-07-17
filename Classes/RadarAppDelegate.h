//
//  RadarAppDelegate.h
//  Radar
//
//  Created by Vladimir Fleurima (iBook) on 7/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"
#import "IntroViewController.h"

@interface RadarAppDelegate : NSObject <UIApplicationDelegate,FBSessionDelegate,TTURLRequestDelegate> {
    UIWindow *window;
	IntroViewController *introViewController;
	UINavigationController *navigationController;
	Facebook *facebook;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IntroViewController *introViewController;
@property (nonatomic, retain) Facebook *facebook;
@property (nonatomic, retain) UINavigationController *navigationController;
- (void) authorizeFB;
- (void) loginToBackend;
+ (NSString *)deviceId;
@end

