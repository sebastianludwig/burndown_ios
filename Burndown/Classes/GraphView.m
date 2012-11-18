//
//  GraphView.m
//  Burndown
//
//  Created by Sebastian Ludwig on 18.11.12.
//  Copyright (c) 2012 Sebastian Ludwig. All rights reserved.
//

#import "GraphView.h"

#import "JDGroupedFlipNumberView.h"

@implementation GraphView
{
	UILabel* label;
	JDGroupedFlipNumberView* flipView;
}

- (id)initWithGrpah:(Graph*)graph
{
	if (self = [super initWithFrame:CGRectMake(0, 0, 600, 100)]) {
		_graph = graph;
		
		// view layout
		{
			label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
			label.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
			label.text = self.graph.label;
			
			flipView = [[JDGroupedFlipNumberView alloc] initWithFlipNumberViewCount: 2];
			flipView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
			flipView.intValue = self.graph.currentValue;
			CGRect frame = flipView.frame;
			frame.origin.x = label.frame.size.width + 20;
			flipView.frame = frame;
			
			self.frame = CGRectMake(0, 0, label.frame.size.width + 20 + flipView.frame.size.width, flipView.frame.size.height);
			[self addSubview:label];
			[self addSubview:flipView];
		}
		
			
		UISwipeGestureRecognizer* upRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(increaseValue)];
		upRecognizer.direction = UISwipeGestureRecognizerDirectionUp;
		[flipView addGestureRecognizer:upRecognizer];
		
		UISwipeGestureRecognizer* downRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(decreaseValue)];
		downRecognizer.direction = UISwipeGestureRecognizerDirectionDown;
		[flipView addGestureRecognizer:downRecognizer];
	}
	return self;
}

- (NSInteger)value
{
	return flipView.intValue;
}

- (void)increaseValue
{
	[flipView animateToNextNumber];
}

- (void)decreaseValue
{
	[flipView animateToPreviousNumber];
}

@end
