//
//  DataPoint.h
//  Burndown
//
//  Created by Sebastian Ludwig on 17.11.12.
//  Copyright (c) 2012 Sebastian Ludwig. All rights reserved.
//

@interface DataPoint : NSObject

@property (nonatomic) NSInteger value;
@property (nonatomic, strong) NSData* date;

- (id)initWithDictionary:(NSDictionary*)dictionary;

@end
