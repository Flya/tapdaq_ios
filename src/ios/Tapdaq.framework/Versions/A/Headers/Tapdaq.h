//
//  Tapdaq.h
//  Tapdaq
//  0.2.6
//
//  Created by Nick Reffitt <nick@tapdaq.com> on 13/09/2013.
//  Copyright 2013 Liquid5 Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum _TQTraditionalPosition : NSUInteger {
    TQTraditionalPositionTop,
    TQTraditionalPositionBottom
} TQTraditionalPosition;

// Forward declaration
@protocol TapdaqDelegate;

@interface Tapdaq : NSObject

@property (nonatomic, weak) id<TapdaqDelegate> delegate;

// The singleton Tapdaq object, use this for all method calls
+ (id)sharedSession;

// A setter for the Application ID of your app, and the Client Key associated with your Tapdaq account
- (void)setApplicationId:(NSString *)applicationId clientKey:(NSString *)clientKey;

// Some quick getters
- (NSString *)getApplicationId;
- (NSString *)getClientKey;

// Displays an interstitial
- (void)showInterstitial;

// Displays the More Apps popup
- (void)showMoreApps;


// Displays a traditional banner and adds the banner as a subview to the provided root view
- (void)showTraditional:(UIView *)rootView;

// Displays a traditional banner at position in the root view
// Options are TQTraditionalPositionTop or TQTraditionalPositionBottom
- (void)showTraditional:(UIView *)rootView
             atPosition:(TQTraditionalPosition)position;

// Displays a traditional banner at a specific position in the root view
// The 2nd parameter provides TQTraditionalPositionTop as the top of the view, or TQTraditionalPositionBottom at the bottom of the view
// The offset determines either how much further down from the top or how much further down fom the bottom should the banner appear, depending on the 2nd parameter
- (void)showTraditional:(UIView *)rootView
             atPosition:(TQTraditionalPosition)position
             withOffset:(float)offset;

@end

@protocol TapdaqDelegate <NSObject>

@optional

// Called before interstitial is shown
- (void)willDisplayInterstitial;

// Called after interstitial is shown
- (void)didDisplayInterstitial;

// Called when interstitial is closed
- (void)didCloseInterstitial;

// Called with an error occurs when requesting
// interstitials from the Tapdaq servers
- (void)didFailToLoadInterstitial;

// Called when the request for interstitials was successful,
// but no interstitials were found
- (void)hasNoInterstitialsAvailable;

// Called before traditional banner is shown
- (void)willDisplayTraditional;

// Called after traditional banner is shown
- (void)didDisplayTraditional;

// Called when no more traditional banners are left to display
- (void)didHideTraditional;

// Called with an error occurs when requesting
// traditionals from the Tapdaq servers
- (void)didFailToLoadTraditional;

// Called when the request for traditionals was successful,
// but no traditionals were found
- (void)hasNoTraditionalsAvailable;

// Called before More Apps popup is shown
- (void)willDisplayMoreApps;

// Called after More Apps popup is shown
- (void)didDisplayMoreApps;

// Called when More Apps popup is closed
- (void)didCloseMoreApps;

// Called with an error occurs when requesting
// More Apps adverts from the Tapdaq servers
- (void)didFailToLoadMoreApps;

// Called when the request for More Apps popup was successful,
// but no More Apps were found
- (void)hasNoMoreAppsAvailable;

@end