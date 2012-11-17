//
//  Sprint.m
//  Burndown
//
//  Created by Sebastian Ludwig on 17.11.12.
//  Copyright (c) 2012 Sebastian Ludwig. All rights reserved.
//

#import "Sprint.h"
#import "Graph.h"

@implementation Sprint

- (id)initWithDictionary:(NSDictionary*)dictionary
{
	if (self = [super init]) {
		self.number = [dictionary[@"number"] integerValue];
		NSMutableArray* graphs = [NSMutableArray arrayWithCapacity:[dictionary[@"graphs"] count]];
		for (NSDictionary* graphData in dictionary[@"graphs"]) {
			Graph* graph = [[Graph alloc] initWithDictionary:graphData];
			if (graph)
				[graphs addObject:graph];
		}
		self.graphs = graphs;
	}
	return self;
}

@end
