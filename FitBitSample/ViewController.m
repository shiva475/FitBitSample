//
//  ViewController.m
//  SampleBit
//
//  Created by Deepak on 1/18/17.
//  Copyright © 2017 InsanelyDeepak. All rights reserved.
//

#import "ViewController.h"
#import "FitbitExplorer.h"
#import "AFNetworking.h"
#import <PhotosUI/PhotosUI.h>
#import <FLAnimatedImage/FLAnimatedImage.h>

@interface ViewController ()

@end

@implementation ViewController
{
    FitbitAuthHandler *fitbitAuthHandler;
    __weak IBOutlet UITextView *resultView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    fitbitAuthHandler = [[FitbitAuthHandler alloc]init:self] ;
    

    NSURL  *url = [[NSBundle mainBundle] URLForResource:@"200w" withExtension:@"gif"];
    FLAnimatedImage *image1 = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfURL:url]];

    self.imageView.animatedImage = image1;
    
    self.imageView1.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    
    resultView.layer.borderColor     = [UIColor lightGrayColor].CGColor;
    resultView.layer.borderWidth     = 2.0f;
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(notificationDidReceived) name:FitbitNotification object:nil];
    
    
    

    
}

-(void)notificationDidReceived{
    resultView.text = @"Authorization Successfull \nPlease press getProfile to fetch data of fitbit user profile";
}
-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (IBAction)actionLogin:(UIButton *)sender {
    //[self performSegueWithIdentifier:@"webVc" sender:nil];
    [fitbitAuthHandler login:self];
}

- (IBAction)actionGetProfile:(UIButton *)sender {

    
    //https://api.fitbit.com/1/user/-/activities/heart/date/"+fDate+"/1d/1sec/time/" + (hour1 - 1) + ":" + (minute1 - 1) + "/" + hour1 + ":" + minute1 + ".json"
    //https://api.fitbit.com/1/user/-/activities/heart/date/2018-04-05/1d/1sec/time/17:11/18:12.json
    NSString *url = [NSString stringWithFormat:@"https://api.fitbit.com/1/user/-/activities/heart/date/2018-04-06/1d/1sec/time/13:47/14:48.json"];
    
    
    NSLog(@"hour......:%ld",(long)[self currentHour]);
    NSLog(@"minute......:%ld",(long)[self currentMinute]);

    NSString *token = [FitbitAuthHandler getToken];
    token = @"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIzUk1GSjIiLCJhdWQiOiIyMjlWVzIiLCJpc3MiOiJGaXRiaXQiLCJ0eXAiOiJhY2Nlc3NfdG9rZW4iLCJzY29wZXMiOiJyc29jIHJzZXQgcmFjdCBybG9jIHJ3ZWkgcmhyIHJudXQgcnBybyByc2xlIiwiZXhwIjoxNTIyOTQ0Nzc1LCJpYXQiOjE1MjI5MTU5NzV9.LMZ73Uy7G8CvaTJOfNBX-MGO7ulGKlYr78bMYlfxKMY";
    FitbitAPIManager *manager = [FitbitAPIManager sharedManager];
    //********** Pass your API here and get details in response **********
    NSString *urlString = [NSString stringWithFormat:@"https://api.fitbit.com/1/user/-/profile.json"] ;
    
    [manager requestGET:url Token:token success:^(NSDictionary *responseObject) {
        // ------ response -----
        NSLog(@"response............:%@",responseObject);
        resultView.text = [responseObject description];
        
    } failure:^(NSError *error) {
        NSData * errorData = (NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
        NSDictionary *errorResponse =[NSJSONSerialization JSONObjectWithData:errorData options:NSJSONReadingAllowFragments error:nil];
        NSArray *errors = [errorResponse valueForKey:@"errors"];
        NSString *errorType = [[errors objectAtIndex:0] valueForKey:@"errorType"] ;
        if ([errorType isEqualToString:fInvalid_Client] || [errorType isEqualToString:fExpied_Token] || [errorType isEqualToString:fInvalid_Token]|| [errorType isEqualToString:fInvalid_Request]) {
            NSLog(@"error type....:%@",errorType);
            // To perform login if token is expired
            //[fitbitAuthHandler login:self];
        }
    }];
}
- (NSInteger)currentMinute
{
    // In practice, these calls can be combined
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitMinute fromDate:now];
    
    return [components minute];
}
- (NSInteger)currentHour
{
    // In practice, these calls can be combined
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitHour fromDate:now];
    
    return [components hour];
}
- (IBAction)actionRevokeAccess:(UIButton *)sender {
    NSString *token = [FitbitAuthHandler getToken];
    [fitbitAuthHandler  revokeAccessToken:@"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIzUk1GSjIiLCJhdWQiOiIyMjlWVzIiLCJpc3MiOiJGaXRiaXQiLCJ0eXAiOiJhY2Nlc3NfdG9rZW4iLCJzY29wZXMiOiJyc29jIHJzZXQgcmFjdCBybG9jIHJ3ZWkgcmhyIHJudXQgcnBybyByc2xlIiwiZXhwIjoxNTIzMDM5MzgxLCJpYXQiOjE1MjMwMTA1ODF9.NVTakzZf8SxOLKDDW_7Q60brCfaCJ49FRRu4_kc3mKA"];
    resultView.text = @"Please press login to authorize";
}

@end
