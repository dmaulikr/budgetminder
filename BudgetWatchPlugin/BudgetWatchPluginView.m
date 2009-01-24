//
//  BudgetWatchPluginView.m
//  BudgetWatchPlugin
//
//  Created by Mario Aquino on 1/22/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "BudgetWatchPluginView.h"

@interface BudgetWatchPluginView (Internal)
- (id)_initWithArguments:(NSDictionary *)arguments;
@end

@implementation BudgetWatchPluginView

// WebPlugInViewFactory protocol
// The principal class of the plug-in bundle must implement this protocol.

+ (NSView *)plugInViewWithArguments:(NSDictionary *)newArguments
{
    return [[[self alloc] _initWithArguments:newArguments] autorelease];
}

- (void) finishedLoading
{
	// update ui
}

- (void) onError: (NSError*) error
{
	// message to user
}

// WebPlugIn informal protocol

- (void)webPlugInInitialize
{
    // This method will be only called once per instance of the plug-in object, and will be called
    // before any other methods in the WebPlugIn protocol.
    // You are not required to implement this method.  It may safely be removed.
	
	workSheet = [BudgetWatchWorksheet newWithUser: @"" andPassword: @"" usingDelegate: self];
}

- (void)webPlugInStart
{
    // The plug-in usually begins drawing, playing sounds and/or animation in this method.
    // You are not required to implement this method.  It may safely be removed.
}

- (void)webPlugInStop
{
    // The plug-in normally stop animations/sounds in this method.
    // You are not required to implement this method.  It may safely be removed.
}

- (void)webPlugInDestroy
{
    // Perform cleanup and prepare to be deallocated.
    // You are not required to implement this method.  It may safely be removed.
}

- (void)webPlugInSetIsSelected:(BOOL)isSelected
{
    // This is typically used to allow the plug-in to alter its appearance when selected.
    // You are not required to implement this method.  It may safely be removed.
}

- (id)objectForWebScript
{
    // Returns the object that exposes the plug-in's interface.  The class of this object can implement
    // methods from the WebScripting informal protocol.
    // You are not required to implement this method.  It may safely be removed.
    return self;
}

@end

@implementation BudgetWatchPluginView (Internal)

- (id)_initWithArguments:(NSDictionary *)newArguments
{
    if (!(self = [super initWithFrame:NSZeroRect]))
        return nil;
    
    return self;
}

@end
