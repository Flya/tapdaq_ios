//
//  TapdaqPlugin.m
//  Sprinkle
//
//  Created by Serg Mukhin on 02.10.14.
//
//

#import "TapdaqPlugin.h"
#import "AppDelegate.h"


@implementation TapdaqPlugin

- (void)pluginInitialize
{
    [super pluginInitialize];
    Tapdaq* instance = [Tapdaq sharedSession];
    [instance setApplicationId:@"542ad5da42892a2b1a2e090b"
                                   clientKey:@"f8035b01-b51a-409b-9aff-254bd9992dc1"];
    instance.delegate = self;
}

- (void)showInterstitial:(CDVInvokedUrlCommand*)command
{
    [[Tapdaq sharedSession] showInterstitial];
    CDVPluginResult *commandResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:nil];
    [self.commandDelegate sendPluginResult:commandResult callbackId:command.callbackId];
}

- (void)showMoreApp:(CDVInvokedUrlCommand*)command
{
    [[Tapdaq sharedSession] showMoreApps];
    CDVPluginResult *commandResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:nil];
    [self.commandDelegate sendPluginResult:commandResult callbackId:command.callbackId];
}

- (NSInteger)congertPosition:(NSString*)position
{
    if([position isEqualToString:@"top"])
    {
        return 1;
    }else if ([position isEqualToString:@"bottom"])
    {
        return 2;
    }
    return -1;
}

- (void)showTraditional:(CDVInvokedUrlCommand*)command
{
    AppDelegate* delegate = [UIApplication sharedApplication].delegate;
    if(command.arguments.count==0)
    {
        [[Tapdaq sharedSession] showTraditional:delegate.window];
    }else if(command.arguments.count==1)
    {
        NSInteger pos = [self congertPosition:command.arguments[0]];
        TQTraditionalPosition position;
        switch (pos) {
            case 1:
                position = TQTraditionalPositionTop;
                break;
            case 2:
                position = TQTraditionalPositionBottom;
                break;
            default:
            {
                CDVPluginResult *commandResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:[NSString stringWithFormat:@"Unknown parameter: %@",command.arguments[0]]];
                [self.commandDelegate sendPluginResult:commandResult callbackId:command.callbackId];
                return;
            }
                break;
        }
        
        [[Tapdaq sharedSession] showTraditional:delegate.window atPosition:position];
        
    }else if(command.arguments.count>1)
    {
        NSInteger pos = [self congertPosition:command.arguments[0]];
        TQTraditionalPosition position;
        switch (pos) {
            case 1:
                position = TQTraditionalPositionTop;
                break;
            case 2:
                position = TQTraditionalPositionBottom;
                break;
            default:
            {
                CDVPluginResult *commandResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:[NSString stringWithFormat:@"Unknown parameter: %@",command.arguments[0]]];
                [self.commandDelegate sendPluginResult:commandResult callbackId:command.callbackId];
                return;
            }
                break;
        }
        
        [[Tapdaq sharedSession] showTraditional:delegate.window atPosition:position withOffset:[command.arguments[1] floatValue]];
    }
    
    CDVPluginResult *commandResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:nil];
    [self.commandDelegate sendPluginResult:commandResult callbackId:command.callbackId];
}


// Called before interstitial is shown
- (void)willDisplayInterstitial
{
    NSLog(@"%s",__func__);
   [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('willdisplayinterstitial'); "];
}

// Called after interstitial is shown
- (void)didDisplayInterstitial
{
    NSLog(@"%s",__func__);
    [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('diddisplayinterstitial'); "];
}


// Called when interstitial is closed
- (void)didCloseInterstitial
{
    NSLog(@"%s",__func__);
   [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('didcloseinterstitial'); "];
}


// Called with an error occurs when requesting
// interstitials from the Tapdaq servers
- (void)didFailToLoadInterstitial
{
    NSLog(@"%s",__func__);
    [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('didfailtoloadinterstitial'); "];
}


// Called when the request for interstitials was successful,
// but no interstitials were found
- (void)hasNoInterstitialsAvailable
{
    NSLog(@"%s",__func__);
    [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('hasnointerstitialsavailable'); "];
}


// Called before traditional banner is shown
- (void)willDisplayTraditional
{
    NSLog(@"%s",__func__);
    [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('willdisplaytraditional'); "];
}


// Called after traditional banner is shown
- (void)didDisplayTraditional
{
    NSLog(@"%s",__func__);
    [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('diddisplaytraditional'); "];
}


// Called when no more traditional banners are left to display
- (void)didHideTraditional
{
    NSLog(@"%s",__func__);
    [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('didhidetraditional'); "];
}


// Called with an error occurs when requesting
// traditionals from the Tapdaq servers
- (void)didFailToLoadTraditional
{
    NSLog(@"%s",__func__);
    [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('didfailtoloadtraditional'); "];
}


// Called when the request for traditionals was successful,
// but no traditionals were found
- (void)hasNoTraditionalsAvailable
{
    NSLog(@"%s",__func__);
    [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('hasnotraditionalsavailable'); "];
}


// Called before More Apps popup is shown
- (void)willDisplayMoreApps
{
    NSLog(@"%s",__func__);
    [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('willdisplaymoreapps'); "];
}


// Called after More Apps popup is shown
- (void)didDisplayMoreApps
{
    NSLog(@"%s",__func__);
    [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('diddisplaymoreapps'); "];
}


// Called when More Apps popup is closed
- (void)didCloseMoreApps
{
    NSLog(@"%s",__func__);
    [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('didclosemoreapps'); "];
}


// Called with an error occurs when requesting
// More Apps adverts from the Tapdaq servers
- (void)didFailToLoadMoreApps
{
    NSLog(@"%s",__func__);
    [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('didfailtoloadmoreapps'); "];
}


// Called when the request for More Apps popup was successful,
// but no More Apps were found
- (void)hasNoMoreAppsAvailable
{
    NSLog(@"%s",__func__);
    [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('hasnomoreappsavailable'); "];
}

@end
