//
//  GraphView.h
//  Burndown
//
//  Created by Sebastian Ludwig on 18.11.12.
//  Copyright (c) 2012 Sebastian Ludwig. All rights reserved.
//

#import "Graph.h"

@interface GraphView : UIView

@property (nonatomic, strong, readonly) Graph* graph;

- (id)initWithGrpah:(Graph*)graph;

- (NSInteger)value;

@end
