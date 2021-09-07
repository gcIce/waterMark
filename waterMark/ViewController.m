//
//  ViewController.m
//  waterMark
//
//  Created by 高诚 on 2021/9/6.
//

#import "ViewController.h"
#import "G_FrameParserConfig.h"
#import "G_WaterMark.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    G_FrameParserConfig *config = [[G_FrameParserConfig alloc] init];
    config.lineSpace = 40;
    config.textColor = [UIColor whiteColor];
    config.fontSize = 22;
    config.spaceSize = 80;
    config.opaque = 0.3;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 100, 340, 480)];
    imageView.image = [G_WaterMark addWatermarkWithImg:[UIImage imageNamed:@"bgImg.jpg"] imageViewSize:imageView.frame.size text:@"胖子"attribute:config waterImage:[UIImage imageNamed:@"newMenu"]];
    [self.view addSubview:imageView];
    // Do any additional setup after loading the view.
}


@end
