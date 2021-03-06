//
//  FlipsideViewController.m
//  BudgetMinder
//
//  Created by David Giovannini on 1/24/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "FlipsideViewController.h"
#import "BudgetMinderWorksheet.h"

@implementation FlipsideViewController

@synthesize user;
@synthesize password;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor viewFlipsideBackgroundColor];      
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated
{
	NSUserDefaults* settings = [NSUserDefaults standardUserDefaults];
	self.user.text = [settings objectForKey: @"user"];
	self.password.text = [settings objectForKey: @"password"];
}

- (IBAction) userChanged: (id) sender
{
	NSUserDefaults* settings = [NSUserDefaults standardUserDefaults];
	[settings setObject: [sender text] forKey: @"user"];
}


- (IBAction) passwordChanged: (id) sender
{
	NSUserDefaults* settings = [NSUserDefaults standardUserDefaults];
	[settings setObject: [sender text] forKey: @"password"];
}



@end
