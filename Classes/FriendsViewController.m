    //
//  FriendsViewController.m
//  Radar
//
//  Created by Vladimir Fleurima (iBook) on 7/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FriendsViewController.h"
#import "FriendListDataSource.h"
#import "Friend.h"
#import "DetailViewController.h"
#import "Detail2ViewController.h"

@implementation FriendsViewController
@synthesize location;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

#pragma mark -
#pragma mark Three20 stuff

- (id)initWithLocation:(CLLocation *)_location {
	if (self = [super initWithNibName:nil bundle:nil]) {
		self.title = @"Friends Near You";
		self.variableHeightRows = NO;
		self.location = _location;
	}
	
	return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)createModel {	
	self.dataSource = [[[FriendListDataSource alloc]
						initWithLocation:self.location] autorelease];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id<UITableViewDelegate>)createDelegate {
	return [[[TTTableViewDragRefreshDelegate alloc] initWithController:self] autorelease];
}

#pragma hax
- (BOOL) shouldOpenURL:(NSString *)URL {
	NSLog(@"we have been consulted");
	return NO;
}

- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath *)indexPath {
	if ([object isKindOfClass:[TTTableItem class]]) {
		TTTableItem *tableItem = (TTTableItem*)object;
		Friend *f = (Friend *)tableItem.userInfo;
		NSLog(@"Clicked on %@", f.name);
		
		UIViewController *dvc = [[Detail2ViewController alloc] initWithFriend:f];
		[self.navigationController pushViewController:dvc animated:YES];
		[dvc release];
	}
}

- (void)dispatchURL:(id)object {
	if ([object isKindOfClass:[TTTableLinkedItem class]]) {
		//TTTableLinkedItem *item = (TTTableLinkedItem*)object;
	}
	NSLog(@"har har har. %@", object);
}

#pragma mark -
#pragma mark Provided methods
- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	TT_RELEASE_SAFELY(location);
    [super dealloc];
}


@end
