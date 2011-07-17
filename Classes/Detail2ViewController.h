//
//  Detail2ViewController.h
//  Radar
//
//  Created by Vladimir Fleurima (iBook) on 7/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Friend.h"

@interface Detail2ViewController : UITableViewController {
	Friend *friend;
}
@property (nonatomic, retain) Friend *friend;
- (id)initWithFriend:(Friend *)_friend;

@end
