//
//  BurndownClient.m
//  Burndown
//
//  Created by Sebastian Ludwig on 17.11.12.
//  Copyright (c) 2012 Sebastian Ludwig. All rights reserved.
//

#import "BurndownClient.h"

@implementation BurndownClient

+ (id)sharedInstance
{
	static BurndownClient* instance;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		instance = [[BurndownClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://localhost:3000/api/v1/"]];
	});
	
	return instance;
}

- (id)initWithBaseURL:(NSURL*)url
{
	if (self = [super initWithBaseURL:url]) {
		[self registerHTTPOperationClass:[AFJSONRequestOperation class]];
		
		[self setDefaultHeader:@"Accept" value:@"application/json;"];
		[self setDefaultHeader:@"Content-Type" value:@"application/json"];
	}
	return self;
}

@end
