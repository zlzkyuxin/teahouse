//
//  UserCenterViewController.m
//  teahouse
//
//  Created by yuxin on 2016/12/26.
//  Copyright © 2016年 yuxin. All rights reserved.
//

#import "UserCenterViewController.h"
#import "LoginViewController.h"
#import "UserCenterTopView.h"
#import "LoginModel.h"

#define userIconRadius 80
@interface UserCenterViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource,
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate
>
{
    LoginModel *userInfo;
//    UIImageView *userIconImage;
//    UILabel *userNameLabel;
    
    UITableView *_tableView;
    
    UserCenterTopView *_topView;
}
@end

@implementation UserCenterViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self initView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //隐藏navigationbar
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"islogin"] || ![[NSUserDefaults standardUserDefaults] objectForKey:@"list"]) {
        [self presentViewController:[LoginViewController new] animated:YES completion:nil];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)loadData {
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"list"];
    TEALog(@"%@",dic);
    userInfo = [LoginModel mj_objectWithKeyValues:dic];
}

- (void)initView {
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, - 20, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    //创建头部视图
    _topView = [[UserCenterTopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT / 2)];
    _topView.userInfo = userInfo;
    WS(weakSelf)
    _topView.block = ^{
        [weakSelf userIconImageClick];
    };
    _tableView.tableHeaderView = _topView;
    
}

#pragma mark - UITableViewDataSource的代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else if (section == 1) {
        return 1;
    }else if (section == 2) {
        return 1;
    }
    return 0;
}
#pragma mark - UITableViewDelegate的代理 
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"usersetting"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"usersetting"];
    }
    if (indexPath.section == 2 && indexPath.row == 0) {
        cell.textLabel.text = @"退出登录";
        cell.textLabel.textColor = [UIColor redColor];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2 && indexPath.row == 0) {
        [self logOut];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2 && indexPath.row == 0) {
        return 64;
    }
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.f;
}

#pragma mark - UIImagePickerControllerDelegate的代理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(nonnull NSDictionary<NSString *,id> *)info {
    //压缩图片
    UIImage *upImage = [UIImage scaleToSize:[info objectForKey:UIImagePickerControllerOriginalImage] size:CGSizeMake(120, 120)];
    //重命名图片
    NSString *upImageName = [NSString stringWithFormat:@"%@%@.png",userInfo.userID,userInfo.userNick];
    //保存图片到沙盒中
    [UIImage savePNGImage:upImage toCachesWithName:upImageName];
    
    NSDictionary *loadDic = [[NSDictionary alloc] init];
    loadDic = @{@"userID":userInfo.userID};
    //上传图片到服务器
//    [[TeaHouseNetWorking shareNetWorking] POST:@"images/userimage/saveimage.php" parameters:loadDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        NSData *imageData = [NSData dataWithContentsOfFile:[UIImage getPNGImageFilePathFromCache:upImageName]];
//        [formData appendPartWithFileData:imageData name:@"header" fileName:upImageName mimeType:@"image/png"];
//    } success:^(NSURLSessionDataTask *task, id responseObject) {
//        //更新数据库用户图像
//        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
//        TEALog(@"%@",result);
//        if ([result[@"code"] intValue] == 200) {
//            _topView.userIconImage.image = [info objectForKey:UIImagePickerControllerOriginalImage];
//            [picker dismissViewControllerAnimated:YES completion:nil];
//        }else {
//            [picker dismissViewControllerAnimated:YES completion:nil];
//        }
//        
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//
//        [picker dismissViewControllerAnimated:YES completion:nil];
//    }];
    
    [TeaHouseNetWorking upload:@"images/userimage/saveimage.php" showHUD:YES parameters:loadDic upImageName:upImageName success:^(id responseObject) {
        //更新数据库用户图像
        if ([responseObject[@"code"] intValue] == 200) {
            _topView.userIconImage.image = [info objectForKey:UIImagePickerControllerOriginalImage];
            [picker dismissViewControllerAnimated:YES completion:nil];
        }else {
            [picker dismissViewControllerAnimated:YES completion:nil];
        }
    } failure:^(NSError *error) {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }];
    
}

//用户图像单击事件
- (void)userIconImageClick {
    //创建选择框
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    //添加相机选择
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"打开相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
        [self presentViewController:imagePicker animated:YES completion:nil];

    }];
    //添加相册选择
    UIAlertAction *picture = [UIAlertAction actionWithTitle:@"打开相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
            
        }
        pickerImage.delegate = self;
        pickerImage.allowsEditing = NO;
        
        [self presentViewController:pickerImage animated:YES completion:nil];
    }];
    [alertVc addAction:cancle];
    [alertVc addAction:camera];
    [alertVc addAction:picture];
    [self presentViewController:alertVc animated:YES completion:nil];
    
}

//登出
- (void)logOut {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"islogin"];
    [self presentViewController:[LoginViewController new] animated:YES completion:nil];
}

@end
