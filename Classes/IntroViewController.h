//
//  IntroViewController.h
//  Radar
//
//  Created by Vladimir Fleurima (iBook) on 7/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntroViewController : UIViewController {
	IBOutlet UIButton *facebookButton;
}

@property (nonatomic, retain) IBOutlet UIButton *facebookButton;
- (IBAction)facebookSignin;
@end
