//
//  RadarAppDelegate.m
//  Radar
//
//  Created by Vladimir Fleurima (iBook) on 7/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RadarAppDelegate.h"
#import "LocationViewController.h"
#import "JSONKit.h"

@implementation RadarAppDelegate

@synthesize window;
@synthesize introViewController, facebook, navigationController;

static NSString *login_url = @"http://radar.dev/login.json";

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.
	introViewController = [[IntroViewController alloc] init];
    self.window.rootViewController = introViewController;
    [self.window makeKeyAndVisible];
    
	//FB stuff
	facebook = [[Facebook alloc] initWithAppId:@"138091546272430"];
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	if ([defaults objectForKey:@"FBAccessTokenKey"] 
        && [defaults objectForKey:@"FBExpirationDateKey"]) {
        facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
        facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
	}
	
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}

#pragma mark -
#pragma mark Facebook

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [facebook handleOpenURL:url]; 
}

- (void)fbDidLogin {
	// Save tokens to defaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[facebook accessToken] forKey:@"FBAccessTokenKey"];
    [defaults setObject:[facebook expirationDate] forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
	
	// Send login request to server
	[self loginToBackend];
	
	// Switch to 2nd screen
	LocationViewController *lvc = [[LocationViewController alloc] init];
	self.navigationController = [[UINavigationController alloc] initWithRootViewController:lvc];
	[window addSubview:self.navigationController.view];
	[lvc release];
}

- (void) authorizeFB {
	NSArray* permissions = [NSArray arrayWithObjects:
		@"friends_checkins", @"friends_location",  @"friends_hometown", nil];
	if ([facebook isSessionValid]) {
		[self fbDidLogin];
	} else {
		[facebook authorize:permissions delegate:self];
	}
}

- (void) loginToBackend {
	NSDictionary *fb_token = [NSMutableDictionary dictionaryWithObject:[facebook accessToken] forKey:@"token"]; 
	NSDictionary *fb_creds = [NSMutableDictionary dictionaryWithObject:fb_token forKey:@"facebook"]; 
	NSMutableArray *credentials = [[NSMutableArray alloc] initWithObjects:fb_creds, nil];

	NSMutableDictionary *parcel = [[NSMutableDictionary alloc] init];
	[parcel setObject:[RadarAppDelegate deviceId] forKey:@"device_udid"];
	[parcel setObject:credentials forKey:@"credentials"];

	
	TTURLRequest *request = [TTURLRequest requestWithURL:login_url delegate:self];
	request.cachePolicy = TTURLRequestCachePolicyNone;
	[request setHttpMethod:@"POST"];
	[request setHttpBody:[parcel JSONData]];
	
	[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
	[request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	[request setValue:[NSString stringWithFormat:@"%d", [[parcel JSONData] length]] 
		forHTTPHeaderField:@"Content-Length"];
		
	//NSLog(@"this is me json: %@", [[NSString alloc] initWithData:[parcel JSONData] encoding:NSUTF8StringEncoding]);
	request.response = [[[TTURLDataResponse alloc] init] autorelease];
	[request send];
		
	TT_RELEASE_SAFELY(credentials);
	TT_RELEASE_SAFELY(parcel);	
}

- (void)requestDidFinishLoad:(TTURLRequest*)request {
	NSLog(@"logged in to backend");
}

static NSString *_deviceId = nil;
+ (NSString *) deviceId {	
	if (!_deviceId) {
#if TARGET_IPHONE_SIMULATOR
		_deviceId = @"F2013F1F-97FE-594F-868D-135FA48FEFB0";
#else
		_deviceId = [[[UIDevice currentDevice] uniqueIdentifier] retain];
#endif          
	}	
	return _deviceId;
}

#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
