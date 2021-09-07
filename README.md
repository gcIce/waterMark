# waterMark
图片添加全屏水印,可添加照片

    引入G_FrameParserConfig.h和G_WaterMark.h 
    //配置水印参数
    G_FrameParserConfig *config = [[G_FrameParserConfig alloc] init];
     //行间距
    config.lineSpace = 40; 
     //字体颜色
    config.textColor = [UIColor whiteColor]; 
 
    //字体大小
    config.fontSize = 22; 
    
    //每个run间距大小 包含图片宽度
    config.spaceSize = 80;
    
    //透明度
    config.opaque = 0.3;
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 100, 340, 480)];
    imageView.image = [G_WaterMark addWatermarkWithImg:[UIImage imageNamed:@"bgImg.jpg"] imageViewSize:imageView.frame.size text:@"胖子"attribute:config waterImage:[UIImage imageNamed:@"newMenu"]];
    [self.view addSubview:imageView];
