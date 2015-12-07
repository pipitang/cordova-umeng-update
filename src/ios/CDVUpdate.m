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
    dispatch_async(dispatch_get_main_queue(), ^{
        NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
        NSString *nowVersion = [infoDict objectForKey:@"CFBundleVersion"];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@", storeAppId]];
        NSString * file =  [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
        
        NSError *error = nil;
        NSDictionary* result = [NSJSONSerialization JSONObjectWithData:[file dataUsingEncoding:NSUTF8StringEncoding]  options:NSJSONReadingAllowFragments error: &error];
        NSArray* results = [result valueForKey:@"results"];
        if ([results lastObject ] != nil) {
            NSString *newVersion = [[results lastObject] valueForKey:@"version"];
            NSLog(@"Versions %@ (old) v.s %@ (new) ", nowVersion, newVersion);
            
            if(![nowVersion isEqualToString:newVersion])
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:title
                                                               delegate:self cancelButtonTitle:cancel otherButtonTitles: ok,nil];
                [alert show];
            }

        }
        [self successWithCallbackID:command.callbackId];
    });


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
