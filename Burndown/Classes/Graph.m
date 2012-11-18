//
//  Graph.m
//  Burndown
//
//  Created by Sebastian Ludwig on 17.11.12.
//  Copyright (c) 2012 Sebastian Ludwig. All rights reserved.
//

#import "Graph.h"
#import "DataPoint.h"

@implementation Graph

- (id)initWithDictionary:(NSDictionary*)dictionary
{
	if (self = [super init]) {
		self.ID = [dictionary[@"id"] integerValue];
		self.label = dictionary[@"label"];
		NSMutableArray* points = [NSMutableArray arrayWithCapacity:[dictionary[@"points"] count]];
		for (NSDictionary* pointData in dictionary[@"points"]) {
			DataPoint* point = [[DataPoint alloc] initWithDictionary:pointData];
			if (point)
				[points addObject:point];
		}
		self.points = points;
	}
	return self;
}

- (NSInteger)currentValue
{
	DataPoint* lastPoint = [self.points lastObject];
	return lastPoint.value;
}

@end
