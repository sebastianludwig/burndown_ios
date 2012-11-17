//
//  DataPoint.m
//  Burndown
//
//  Created by Sebastian Ludwig on 17.11.12.
//  Copyright (c) 2012 Sebastian Ludwig. All rights reserved.
//

#import "DataPoint.h"

@implementation DataPoint

- (id)initWithDictionary:(NSDictionary*)dictionary
{
	if (self = [super init]) {
		self.value = [dictionary[@"value"] integerValue];
	}
	return self;
}

@end
