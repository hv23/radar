//
//  FriendListDataSource.h
//  Radar
//
//  Created by Vladimir Fleurima (iBook) on 7/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FriendListModel.h"

@interface FriendListDataSource : TTListDataSource {
	FriendListModel *model;
}

-(id)initWithLocation:(CLLocation *)location;
@end
