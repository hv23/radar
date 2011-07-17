//
//  FriendListDataSource.m
//  Radar
//
//  Created by Vladimir Fleurima (iBook) on 7/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FriendListDataSource.h"
#import "FriendListModel.h"
#import "Friend.h"

// Three20 Additions
#import <Three20Core/NSDateAdditions.h>

@implementation FriendListDataSource
///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithLocation:(CLLocation *)location {
	if (self = [super init]) {
		model = [[FriendListModel alloc] initWithLocation:location];
	}
	
	return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
	TT_RELEASE_SAFELY(model);	
	[super dealloc];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id<TTModel>)model {
	return model;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)tableViewDidLoadModel:(UITableView*)tableView {
	NSMutableArray* items = [[NSMutableArray alloc] init];
	
	NSLog(@"FriendListDataSource - tableViewDidLoadModel start");
	for (Friend* friend in model.friends) {
		/*
		TTStyledText* styledText = [TTStyledText textFromXHTML:
									[friend name] lineBreaks:YES URLs:NO];

		TTTableStyledTextItem *textItem = [TTTableStyledTextItem itemWithText:styledText];
		//textItem.selector = @selector(selectorTest);
		[items addObject:textItem];
		 */
		/*
		[items addObject:[TTTableMessageItem itemWithTitle: friend.name
												   caption: friend.network
													  text: friend.location
												 timestamp: nil
												  imageURL: friend.profileImage
													   URL: friend.profileUrl]];
		 */
		TTTableImageItem *item = [TTTableImageItem itemWithText:friend.name 
										imageURL:friend.profileImage 
											 URL:friend.profileUrl];
		item.userInfo = friend;
		[items addObject:item];
	}
	NSLog(@"FriendListDataSource - tableViewDidLoadModel loop finished");

	if (!model.finished) {
		[items addObject:[TTTableMoreButton itemWithText:@"more..."]];
	}
	
	self.items = items;
	TT_RELEASE_SAFELY(items);
	NSLog(@"FriendListDataSource - tableViewDidLoadModel end");
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)titleForLoading:(BOOL)reloading {
	if (reloading) {
		return NSLocalizedString(@"Searching for friends...", @"Radar searching for friends");
	} else {
		return NSLocalizedString(@"Loading friends...", @"Radar loading friends");
	}
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)titleForEmpty {
	return NSLocalizedString(@"No friends nearby.", @"No results.");
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)subtitleForError:(NSError*)error {
	return NSLocalizedString(@"Sorry, there was an error loading your friend list.", @"");
}

-(void)selectorTest {
	NSLog(@"tapped!");
}

@end
