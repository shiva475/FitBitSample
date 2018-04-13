//
//  WebViewController.m
//  FitBitSample
//
//  Created by Gowtham on 30/03/18.
//  Copyright © 2018 SmartRx. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()
{
    NSString  *clientID;
    NSString  *clientSecret ;
    NSURL     *authUrl ;
    NSURL     *refreshTokenUrl ;
    NSString  *redirectURI  ;
    NSString  *defaultScope ;
    NSString  *expiresIn ;
    
    NSString *authenticationCode;

}
@end

@implementation WebViewController
-(void)loadVars{
    //------ Initialize all required vars -----
    clientID         = @"229VW2";
    clientSecret     = @"";
    redirectURI      = @"https://dev.medcall.in/fitbit_call_back.php";
    expiresIn        = @"31536000";
    authUrl          = [NSURL URLWithString:@"https://www.fitbit.com/oauth2/authorize"];
    refreshTokenUrl  = [NSURL URLWithString:@"https://api.fitbit.com/oauth2/token"];
    defaultScope     = @"sleep%20settings%20nutrition%20activity%20social%20heartrate%20profile%20weight%20location";
    
    /** expiresIn Details
     // 86400 for 1 day
     // 604800 for 1 week
     // 2592000 for 30 days
     // 31536000 for 1 year
     */
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadVars];
    
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?response_type=code&client_id=%@&redirect_uri=%@&scope=%@&expires_in=%@",authUrl,clientID,redirectURI,defaultScope,expiresIn]];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
