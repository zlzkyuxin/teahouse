//
//  ScanViewController.m
//  teahouse
//
//  Created by zlzk on 16/12/26.
//  Copyright © 2016年 yuxin. All rights reserved.
//

#import "ScanViewController.h"
#import "ScanCodeView.h"
#import "ScanResultController.h"
#import <AVFoundation/AVFoundation.h>
@interface ScanViewController ()
<
    AVCaptureMetadataOutputObjectsDelegate
>
@property (nonatomic , strong)AVCaptureDevice *device;
@property (nonatomic , strong)AVCaptureDeviceInput *input;
@property (nonatomic , strong)AVCaptureMetadataOutput *output;
@property (nonatomic , strong)AVCaptureSession *session;
@property (nonatomic , strong)AVCaptureVideoPreviewLayer *preview;
@property (nonatomic , strong)ScanCodeView *scanCodeView;
@end

@implementation ScanViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _scanCodeView = [[ScanCodeView alloc] initWithFrame:self.view.frame outsideViewLayer:self.view.layer];
    [self.view addSubview:_scanCodeView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView {
    [self.view setBackgroundColor:[UIColor whiteColor]];
    //获取摄像设备
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //创建输入流
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    //创建输出流
    _output = [[AVCaptureMetadataOutput alloc] init];
    //设置代理 在主线程里刷新
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    //设备扫描范围(0-1,左上角为原点)
    _output.rectOfInterest = CGRectMake(0.05, 0.2, 0.7, 0.6);
    
    //初始化session 高质量采集
    _session = [[AVCaptureSession alloc] init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    //添加会话输入和输出
    if ([_session canAddInput:self.input]) {
        [_session addInput:self.input];
    }
    if ([_session canAddOutput:self.output]) {
        [_session addOutput:self.output];
    }
    //设置输出数据类型,先将元数据输出添加到会话再指定元数据类型
    //设置扫码支持编码格式
    _output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeCode128Code];
    //实例化预览图层,传递session是为了告诉图层显示的内容
    _preview = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _preview.frame = self.view.layer.bounds;
    //将图层插入当前视图
    [self.view.layer insertSublayer:_preview atIndex:0];
    //启动会话
    [_session startRunning];
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    TEALog(@"会频繁的扫描，调用代理方法");
    [_session stopRunning];//停止会话
    [_preview removeFromSuperlayer];//删除预览图层
    if (metadataObjects.count > 0) {
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        TEALog(@"metadataObjects---%@",obj);
        
        if ([obj.stringValue hasPrefix:@"http"]) {
            TEALog(@"网页跳转");
            ScanResultController *result = [[ScanResultController alloc] init];
            result.resultURL = obj.stringValue;
            [self presentViewController:result animated:YES completion:nil];
        }else {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:obj.stringValue preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:okAction];
            [self presentViewController:alert animated:YES completion:nil];
            TEALog(@"条形码或者字符--%@",obj.stringValue);
//            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_scanCodeView removeTimer];
    [_scanCodeView removeFromSuperview];
    _scanCodeView = nil;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
