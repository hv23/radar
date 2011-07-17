//
//  LocationViewController.m
//  Radar
//
//  Created by Vladimir Fleurima (iBook) on 7/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LocationViewController.h"
#import "FriendsViewController.h"

@implementation LocationViewController
@synthesize lookupCurrentLocationButton, lastSeenLocation;

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

-(id)init {
    self = [super initWithNibName:@"LocationViewController" bundle:nil];
    if (self) {
        // Custom initialization.
    }
    return self;
}

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

#pragma mark -
#pragma mark Location stuff
- (IBAction) getCurrentLocation {
	if (nil == locationManager) {
        locationManager = [[CLLocationManager alloc] init];
        
		locationManager.delegate = self;
		//locationManager.purpose = @"GPS is necessary to use this application.";
		locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
	}	
	[locationManager startUpdatingLocation];
}

// Delegate method from the CLLocationManagerDelegate protocol.
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation {

	self.lastSeenLocation = newLocation;
	[locationManager stopUpdatingLocation];
	
	FriendsViewController *fvc = [[FriendsViewController alloc] initWithLocation:newLocation];
	[self.navigationController pushViewController:fvc animated:YES];
	
	[fvc release];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
	NSLog(@"Error fetching location: %@", [error localizedDescription]);
}

- (void)dealloc {
    [super dealloc];
}


@end
