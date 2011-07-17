//
//  FriendListModel.m
//  Radar
//
//  Created by Vladimir Fleurima (iBook) on 7/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FriendListModel.h"
#import "Friend.h"
#import "JSONKit.h"

@implementation FriendListModel
//static NSString *lookup_url = @"http://radar.dev/nearby.json?lat=%@&lng=%@";
static NSString *lookup_url = @"http://localhost/nearby.json?lat=%@&lng=%@";
@synthesize location, friends, finished, resultsPerPage;

- (id)initWithLocation:(CLLocation *)_location {
	if (self = [super init]) {
		self.location = _location;
		_resultsPerPage = 10;
		_page = 1;
		friends = [[NSMutableArray array] retain];
	}
	
	return self;	
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void) dealloc {
	TT_RELEASE_SAFELY(location);
	TT_RELEASE_SAFELY(friends);
	[super dealloc];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more {
	NSLog(@"FriendListModel - load start");
	if (!self.isLoading) {
		if (more) {
			_page++;
		}
		else {
			_page = 1;
			_finished = NO;
			[friends removeAllObjects];
		}
		
        NSString *latStr = [NSString stringWithFormat:@"%+.6f", location.coordinate.latitude];
        NSString *lonStr = [NSString stringWithFormat:@"%+.6f", location.coordinate.longitude];
		NSString *url = [NSString stringWithFormat:lookup_url, latStr, lonStr];
		
		TTURLRequest* request = [TTURLRequest
								 requestWithURL: url
								 delegate: self];
		
		request.cachePolicy = cachePolicy;
		request.cacheExpirationAge = 0;
		
		/*
		TTURLJSONResponse* response = [[TTURLJSONResponse alloc] init];
		request.response = response;
		TT_RELEASE_SAFELY(response);
		*/
		request.response = [[[TTURLDataResponse alloc] init] autorelease];
		[request send];		
	}
	NSLog(@"FriendListModel - load end");

}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)requestDidFinishLoad:(TTURLRequest*)request {
	NSLog(@"FriendListModel - requestDidFinishLoad start");
	TTURLDataResponse *response = (TTURLDataResponse *)request.response;
	NSArray *friend_array = [response.data objectFromJSONData];

	NSLog(@"FriendListModel - requestDidFinishLoad json parsed");
	NSMutableArray* _friends = [NSMutableArray arrayWithCapacity:[friend_array count]];
	for (NSDictionary *friend_dict in friend_array) {
		Friend *f = [[Friend alloc] init];

		f.name = [friend_dict objectForKey:@"name"];
		f.network = [friend_dict objectForKey:@"network"];
		f.location = [friend_dict objectForKey:@"location"];
		f.profileUrl = [friend_dict objectForKey:@"link"];
		f.profileImage = [friend_dict objectForKey:@"image"];
		f.phone = [friend_dict objectForKey:@"phone"];
		f.email = [friend_dict objectForKey:@"email"];
		f.latest_status = [friend_dict objectForKey:@"last_status"];
		
		[_friends addObject:f];
		TT_RELEASE_SAFELY(f);
	}
	NSLog(@"FriendListModel - requestDidFinishLoad out of loop");	
	[friends addObjectsFromArray:_friends];
	[super requestDidFinishLoad:request];
	NSLog(@"FriendListModel - requestDidFinishLoad end");
}


@end
