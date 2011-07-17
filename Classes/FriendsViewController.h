//
//  FriendsViewController.h
//  Radar
//
//  Created by Vladimir Fleurima (iBook) on 7/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface FriendsViewController : TTTableViewController {
	CLLocation *location;
}

@property (nonatomic, retain) CLLocation *location;
- (id)initWithLocation:(CLLocation *)location;
@end
