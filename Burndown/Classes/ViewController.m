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
	NSDateFormatter* dateFormater;
}

#pragma mark -
#pragma mark UIViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		dateFormater = [[NSDateFormatter alloc] init];
		[dateFormater setDateFormat:@"yyyy-MM-dd"];
	}
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self refresh];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	return YES;
}

#pragma mark Actions

- (IBAction)refresh
{
	BurndownClient* client = [BurndownClient sharedInstance];
	[client getPath:@"sprints/current"
		 parameters:nil
			success:^(AFHTTPRequestOperation *operation, id responseObject) {
				sprint = [[Sprint alloc] initWithDictionary:responseObject[@"sprint"]];
				[self updateView];
			}
			failure:^(AFHTTPRequestOperation *operation, NSError *error) {
				NSLog(@"Error: %@", error);
			}];
}

- (IBAction)submit
{
	BurndownClient* client = [BurndownClient sharedInstance];
	for (GraphView* graphView in graphViews) {
		NSString* path = [NSString stringWithFormat:@"sprints/%d/graphs/%d/points", sprint.ID, graphView.graph.ID];
		[client postPath:path
			  parameters:@{
					@"value": [NSNumber numberWithInt:graphView.value],
					@"date": [dateFormater stringFromDate:[NSDate date]]
				 }
				 success:^(AFHTTPRequestOperation* operation, id responseObject) {
					 NSLog(@"success %@", responseObject);
				 }
				 failure:^(AFHTTPRequestOperation* operation, NSError* error) {
					 NSLog(@"Error: %@", error);
				 }];
	}
}

#pragma mark -
#pragma mark ViewController

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
		graphView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		
		CGRect frame = graphView.frame;
		frame.origin.y = i * (frame.size.height + 20) + 100;
		frame.size.width = self.view.frame.size.width;
		graphView.frame = frame;
		[self.view addSubview:graphView];
		[graphViews addObject:graphView];
	}
}

@end
