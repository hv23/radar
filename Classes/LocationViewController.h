//
//  LocationViewController.h
//  Radar
//
//  Created by Vladimir Fleurima (iBook) on 7/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


@interface LocationViewController : UIViewController <CLLocationManagerDelegate> {
	CLLocationManager *locationManager;
	CLLocation *lastSeenLocation;
	IBOutlet UIButton *lookupCurrentLocationButton;
}

- (IBAction) getCurrentLocation;
@property (nonatomic, retain) IBOutlet UIButton *lookupCurrentLocationButton;
@property (nonatomic, retain) CLLocation *lastSeenLocation;

@end
