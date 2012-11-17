//
//  BurndownClient.h
//  Burndown
//
//  Created by Sebastian Ludwig on 17.11.12.
//  Copyright (c) 2012 Sebastian Ludwig. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface BurndownClient : AFHTTPClient

+ (id)sharedInstance;

@end
