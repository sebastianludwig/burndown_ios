//
//  Graph.h
//  Burndown
//
//  Created by Sebastian Ludwig on 17.11.12.
//  Copyright (c) 2012 Sebastian Ludwig. All rights reserved.
//

@interface Graph : NSObject

@property (nonatomic) NSInteger ID;
@property (nonatomic, strong) NSString* label;
@property (nonatomic, strong) NSArray* points;

- (id)initWithDictionary:(NSDictionary*)dictionary;

- (NSInteger)currentValue;

@end
