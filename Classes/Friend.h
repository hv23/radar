//
//  Friend.h
//  Radar
//
//  Created by Vladimir Fleurima (iBook) on 7/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Friend : NSObject {
	NSString *name, *location, *network, *profileImage, *profileUrl;
}

@property (nonatomic, retain) NSString *name, *location, *network, *profileImage, *profileUrl;
@end
