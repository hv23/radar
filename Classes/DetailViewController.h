//
//  DetailViewController.h
//  Radar
//
//  Created by Vladimir Fleurima (iBook) on 7/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Friend.h"

@interface DetailViewController : UIViewController <UIWebViewDelegate> {
	IBOutlet UIWebView *webView;
	Friend *friend;
}
@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, retain) Friend *friend;
- (id)initWithFriend:(Friend *)_friend;

@end
