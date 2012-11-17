//
//  ViewController.m
//  Burndown
//
//  Created by Sebastian Ludwig on 16.11.12.
//  Copyright (c) 2012 Sebastian Ludwig. All rights reserved.
//

#import "ViewController.h"

#import "BurndownClient.h"
#import <AFNetworking.h>
#import "JDGroupedFlipNumberView.h"

@implementation ViewController
{
	NSURLConnection* connection;
	NSMutableData* receivedData;
	NSDictionary* json;
}

#pragma mark -
#pragma mark UIViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		receivedData = [NSMutableData dataWithLength:1024];
	}
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self refresh];
	
	BurndownClient* client = [BurndownClient sharedInstance];
	[client getPath:@"sprints/current.json"
		 parameters:nil
			success:^(AFHTTPRequestOperation *operation, id responseObject) {
				NSLog(@"%@", responseObject);
			}
			failure:^(AFHTTPRequestOperation *operation, NSError *error) {
				NSLog(@"Error: %@", error);
			}];

	JDGroupedFlipNumberView* flipView = [[JDGroupedFlipNumberView alloc] initWithFlipNumberViewCount: 5];
    flipView.intValue = 11115;
	//[flipView animateDownWithTimeInterval: 1.5];
	//[flipView animateUpWithTimeInterval:1.5];
    [self.view addSubview:flipView];
}

#pragma mark -
#pragma mark ViewController

- (void)refresh
{
	NSURL* url = [NSURL URLWithString:@"http://localhost:3000/sprints/current.json"];
	
	connection = [[NSURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:url] delegate:self];
	[connection start];
}

- (void)updateView
{
	NSLog(@"%@", json);
}

@end
