//
//  FriendListModel.h
//  Radar
//
//  Created by Vladimir Fleurima (iBook) on 7/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface FriendListModel : TTURLRequestModel {
	CLLocation *location;
	
	NSMutableArray*  friends;
	
	NSUInteger _page;             // page of search request
	NSUInteger _resultsPerPage;   // results per page, once the initial query is made
	// this value shouldn't be changed
	BOOL _finished;
}

@property (nonatomic, retain)   CLLocation *location;
@property (nonatomic, readonly) NSMutableArray* friends;
@property (nonatomic, assign)   NSUInteger      resultsPerPage;
@property (nonatomic, readonly) BOOL            finished;

- (id)initWithLocation:(CLLocation *)_location;

@end
