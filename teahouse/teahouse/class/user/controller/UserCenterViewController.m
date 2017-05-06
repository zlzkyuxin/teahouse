//
//  UserCenterViewController.m
//  teahouse
//
//  Created by yuxin on 2016/12/26.
//  Copyright © 2016年 yuxin. All rights reserved.
//

#import "UserCenterViewController.h"
#import "LoginViewController.h"
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
    UIImageView *userIconImage;
    UILabel *userNameLabel;
    
    UITableView *_tableView;
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
    NSLog(@"%@",dic);
    userInfo = [LoginModel mj_objectWithKeyValues:dic];
}

- (void)initView {
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    //创建头部视图
    _tableView.tableHeaderView = [self creatTopView];
    
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
    [[TeaHouseNetWorking shareNetWorking] POST:@"images/userimage/saveimage.php" parameters:loadDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSData *imageData = [NSData dataWithContentsOfFile:[UIImage getPNGImageFilePathFromCache:upImageName]];
        [formData appendPartWithFileData:imageData name:@"header" fileName:upImageName mimeType:@"image/png"];
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        //更新数据库用户图像
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
        NSLog(@"%@",result);
        if ([result[@"code"] intValue] == 200) {
            userIconImage.image = [info objectForKey:UIImagePickerControllerOriginalImage];
            [picker dismissViewControllerAnimated:YES completion:nil];
        }else {
            [picker dismissViewControllerAnimated:YES completion:nil];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {

        [picker dismissViewControllerAnimated:YES completion:nil];
    }];
    
}

//创建头部视图
- (UIView *)creatTopView {
    //头部最底层容器
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT / 2)];
    [self.view addSubview:backView];
    
    //上半部
    UIView *upView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, backView.frame.size.height / 2)];
    upView.backgroundColor = [UIColor greenColor];
    [backView addSubview:upView];
    
    //下半部
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(upView.frame), SCREEN_WIDTH, backView.frame.size.height / 2)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [backView addSubview:bottomView];
    
    //头像
    userIconImage = [UIImageView new];
    [backView addSubview:userIconImage];
    [userIconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(backView.mas_centerX);
        make.centerY.equalTo(backView.mas_centerY).offset(-userIconRadius/4);
        make.width.mas_equalTo(userIconRadius);
        make.height.mas_equalTo(userIconRadius);
    }];
//    [userIconImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@userimage/%@",ImageURL,userInfo.userImage]]];
    //刷新本地缓存图片
    NSURL *imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@userimage/%@",ImageURL,userInfo.userImage]];
    [userIconImage sd_setImageWithURL:imageUrl placeholderImage:nil options:SDWebImageRefreshCached];
    
    userIconImage.layer.cornerRadius = userIconRadius / 2;
    userIconImage.layer.masksToBounds = YES;
    //给头像添加单击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userIconImageClick)];
    userIconImage.userInteractionEnabled = YES;
    [userIconImage addGestureRecognizer:tap];
    
    //用户名
    userNameLabel = [UILabel new];
    [bottomView addSubview:userNameLabel];
    [userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView);
        make.right.equalTo(bottomView);
        make.height.mas_equalTo(@20);
        make.centerY.equalTo(bottomView.mas_centerY).offset(-25);
    }];
    userNameLabel.text = userInfo.userNick;
    userNameLabel.textAlignment = NSTextAlignmentCenter;
    
    //用户名底部分割线
    UIView *line1 = [UIView new];
    line1.backgroundColor = UIColorFromHexadecimalRGB(0xcccccc);
    [bottomView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView);
        make.right.equalTo(bottomView);
        make.height.mas_equalTo(@0.5);
        make.centerY.equalTo(bottomView.mas_centerY);
    }];
    
    //垂直分割线
    UIView *line2 = [UIView new];
    line2.backgroundColor = UIColorFromHexadecimalRGB(0xcccccc);
    [bottomView addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line1.mas_bottom).offset(8);
        make.bottom.equalTo(bottomView).offset(-8);
        make.width.mas_equalTo(@0.5);
        make.centerX.equalTo(bottomView.mas_centerX);
    }];
    
    //底部分割线
    UIView *line3 = [UIView new];
    line3.backgroundColor = UIColorFromHexadecimalRGB(0xcccccc);
    [bottomView addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView);
        make.right.equalTo(bottomView);
        make.height.mas_equalTo(@0.5);
        make.bottom.equalTo(bottomView);
    }];
    
    return backView;
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
