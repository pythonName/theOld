//
//  AddOldManAlterView.m
//  theOld
//
//  Created by 拓润公司 on 2017/11/17.
//  Copyright © 2017年 loary. All rights reserved.
//

#import "AddOldManAlterView.h"

static NSString *cellIdent = @"UITableViewCell";
@implementation AddOldManAlterView

+(AddOldManAlterView*)loadAddOldManAlterView {
    AddOldManAlterView *vv = (AddOldManAlterView *)[self loadFromNIB];
    [[UIApplication sharedApplication].keyWindow addSubview:vv];
    return vv;
}
 
- (void)awakeFromNib {
    [super awakeFromNib];
    self.backView.alpha = 0.6;
    self.whiterView.layer.cornerRadius = 10;
}


- (IBAction)selectButtonClick:(id)sender {
    _dataArr = @[@"子女",@"亲戚",@"其他"];
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(23+CGRectGetMinX(self.whiterView.frame), CGRectGetMidY(self.whiterView.frame)+15, CGRectGetWidth(self.selectBtn.frame), 120) style:UITableViewStylePlain];
    [self addSubview:_mainTableView];
    _mainTableView.delegate= self;
    _mainTableView.dataSource = self;
    _mainTableView.backgroundColor = [UIColor whiteColor];
    [_mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdent];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
    cell.textLabel.text = _dataArr[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.selectBtn setTitle:_dataArr[indexPath.row] forState:UIControlStateNormal];
    [_mainTableView removeFromSuperview];
}

@end
