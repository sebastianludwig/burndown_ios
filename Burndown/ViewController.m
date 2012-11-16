//
//  ViewController.m
//  Burndown
//
//  Created by Sebastian Ludwig on 16.11.12.
//  Copyright (c) 2012 Sebastian Ludwig. All rights reserved.
//

#import "JSONKit.h"

#import "ViewController.h"

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

#pragma mark -
#pragma mark NSURLConnectionDelegate

- (void)connection:(NSURLConnection*)connection didReceiveResponse:(NSURLResponse*)response
{
    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection*)connection didReceiveData:(NSData*)data
{
    [receivedData appendData:data];
}

- (void)connection:(NSURLConnection*)failedConnection didFailWithError:(NSError*)error
{
	if (failedConnection != connection)
		return;
	
	connection = nil;
	UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
	[alert show];
}

- (void)connectionDidFinishLoading:(NSURLConnection*)finishedConnection
{
	if (finishedConnection != connection)
		return;
	
    NSError* error;
    
	json = [receivedData objectFromJSONDataWithParseOptions:JKParseOptionNone error:&error];
	if (error) {
		UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alert show];
		return;
	}
	
	[self updateView];
}

- (NSCachedURLResponse*)connection:(NSURLConnection*)connection willCacheResponse:(NSCachedURLResponse*)cachedResponse
{
    return nil;
}

@end
