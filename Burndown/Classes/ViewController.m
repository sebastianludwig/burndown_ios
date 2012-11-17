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
#import "Sprint.h"
#import "Graph.h"

@implementation ViewController
{
	Sprint* sprint;
	NSMutableArray* flipViews;
}

#pragma mark -
#pragma mark UIViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		
	}
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self refresh];
}

#pragma mark -
#pragma mark ViewController

- (void)refresh
{
	BurndownClient* client = [BurndownClient sharedInstance];
	[client getPath:@"sprints/current.json"
		 parameters:nil
			success:^(AFHTTPRequestOperation *operation, id responseObject) {
				sprint = [[Sprint alloc] initWithDictionary:responseObject[@"sprint"]];
				[self updateView];
			}
			failure:^(AFHTTPRequestOperation *operation, NSError *error) {
				NSLog(@"Error: %@", error);
			}];
}

- (void)updateView
{
	for (UIView* flipView in flipViews) {
		[flipView removeFromSuperview];
	}
	
	if (!sprint)
		return;
	
	flipViews = [NSMutableArray arrayWithCapacity:sprint.graphs.count];
	
	for (int i = 0; i < sprint.graphs.count; ++i) {
		Graph* graph = sprint.graphs[i];
		JDGroupedFlipNumberView* flipView = [[JDGroupedFlipNumberView alloc] initWithFlipNumberViewCount: 5];
		flipView.intValue = graph.currentValue;
		CGRect frame = flipView.frame;
		frame.origin.y = i * 80 + 20;
		flipView.frame = frame;
		[self.view addSubview:flipView];
		[flipViews addObject:flipView];
	}
}

@end
