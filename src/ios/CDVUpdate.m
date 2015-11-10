#import "CDVUpdate.h"



@interface  CDVUpdate()
   @property NSString* storeAppId;
@end

@implementation CDVUpdate
@synthesize storeAppId;

#pragma API

- (void)checkUpdate:(CDVInvokedUrlCommand *)command
{
    storeAppId = [command.arguments objectAtIndex:0];
    NSDictionary *desc = [command.arguments objectAtIndex:1];
    
    NSString *title = [desc objectForKey:@"title"];
    NSString *ok = [desc objectForKey:@"ok"];
    NSString *cancel = [desc objectForKey:@"cancel"];
    
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    
    NSString *nowVersion = [infoDict objectForKey:@"CFBundleVersion"];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@", storeAppId]];
    NSString * file =  [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    
    NSLog(@"Got response %@", file);
    
    NSRange substr = [file rangeOfString:@"\"version\":\""];
    NSRange range1 = NSMakeRange(substr.location+substr.length,10);
    NSRange substr2 =[file rangeOfString:@"\"" options:0 range:range1];
    NSRange range2 = NSMakeRange(substr.location+substr.length, substr2.location-substr.location-substr.length);
    NSString *newVersion =[file substringWithRange:range2];
    
    NSLog(@"Versions %@ (old) v.s %@ (new) ", nowVersion, newVersion);
    
    if(![nowVersion isEqualToString:newVersion])
    {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:title
                delegate:self cancelButtonTitle:cancel otherButtonTitles: ok,nil];
        [alert show];
    }

    [self successWithCallbackID:command.callbackId];
}


- (void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1)
    {
        // 此处加入应用在app store的地址，方便用户去更新，一种实现方式如下：
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/us/app/id%@?ls=1&mt=8",storeAppId]];
        [[UIApplication sharedApplication] openURL:url];
    }
}

#pragma util
- (void)successWithCallbackID:(NSString *)callbackID
{
    [self successWithCallbackID:callbackID withMessage:@"OK"];
}

- (void)successWithCallbackID:(NSString *)callbackID withMessage:(NSString *)message
{
    CDVPluginResult *commandResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:message];
    [self.commandDelegate sendPluginResult:commandResult callbackId:callbackID];
}

- (void)failWithCallbackID:(NSString *)callbackID withError:(NSError *)error
{
    [self failWithCallbackID:callbackID withMessage:[error localizedDescription]];
}

- (void)failWithCallbackID:(NSString *)callbackID withMessage:(NSString *)message
{
    CDVPluginResult *commandResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:message];
    [self.commandDelegate sendPluginResult:commandResult callbackId:callbackID];
}

@end
