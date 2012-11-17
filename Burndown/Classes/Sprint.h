//
//  Sprint.h
//  Burndown
//
//  Created by Sebastian Ludwig on 17.11.12.
//  Copyright (c) 2012 Sebastian Ludwig. All rights reserved.
//

@interface Sprint : NSObject

@property (nonatomic) NSInteger number;
@property (nonatomic, strong) NSArray* graphs;

- (id)initWithDictionary:(NSDictionary*)dictionary;

@end
