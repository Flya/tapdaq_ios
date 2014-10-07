//
//  TapdaqPlugin.h
//  Sprinkle
//
//  Created by Serg Mukhin on 02.10.14.
//
//

#import <Cordova/CDVPlugin.h>
#import <Tapdaq/Tapdaq.h>

@interface TapdaqPlugin : CDVPlugin<TapdaqDelegate>
- (void)showInterstitial:(CDVInvokedUrlCommand*)command;
@end
