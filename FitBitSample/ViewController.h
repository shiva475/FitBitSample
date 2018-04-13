//
//  ViewController.h
//  FitBitSample
//
//  Created by Gowtham on 30/03/18.
//  Copyright © 2018 SmartRx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FLAnimatedImage/FLAnimatedImageView.h>


@interface ViewController : UIViewController

@property(nonatomic,weak) IBOutlet FLAnimatedImageView *imageView;

@property(nonatomic,weak) IBOutlet UIImageView *imageView1;

- (IBAction)actionLogin:(UIButton *)sender;
- (IBAction)actionGetProfile:(UIButton *)sender;
- (IBAction)actionRevokeAccess:(UIButton *)sender;
@end

