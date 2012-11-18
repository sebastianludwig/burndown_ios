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

#import "Sprint.h"
#import "Graph.h"
#import "GraphView.h"

@implementation ViewController
{
	Sprint* sprint;
	NSMutableArray* graphViews;
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
	for (UIView* graphView in graphViews) {
		[graphView removeFromSuperview];
	}
	
	if (!sprint)
		return;
	
	graphViews = [NSMutableArray arrayWithCapacity:sprint.graphs.count];
	
	for (int i = 0; i < sprint.graphs.count; ++i) {
		Graph* graph = sprint.graphs[i];
		GraphView* graphView = [[GraphView alloc] initWithGrpah:graph];
		
		CGRect frame = graphView.frame;
		frame.origin.y = i * (frame.size.height + 20) + 20;
		graphView.frame = frame;
		[self.view addSubview:graphView];
		[graphViews addObject:graphView];
	}
}

@end
