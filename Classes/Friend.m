//
//  Friend.m
//  Radar
//
//  Created by Vladimir Fleurima (iBook) on 7/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Friend.h"


@implementation Friend

@synthesize name, location, network, profileImage, profileUrl;
@synthesize phone, email, latest_status;

- (void) dealloc {
	TT_RELEASE_SAFELY(name);
	TT_RELEASE_SAFELY(location);
	TT_RELEASE_SAFELY(network);
	TT_RELEASE_SAFELY(profileImage);
	TT_RELEASE_SAFELY(profileUrl);
	[super dealloc];
}

@end
