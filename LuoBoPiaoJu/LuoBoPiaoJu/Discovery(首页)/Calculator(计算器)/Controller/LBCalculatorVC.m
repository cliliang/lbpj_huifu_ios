//
//  LBCalculatorVC.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/8/8.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBCalculatorVC.h"
#import "LBCalcDetailVC.h"
#import "LBCaluTVCell_1.h"
#import "LBCaluTVCell_2.h"
#import "LBCaluTVCell_3.h"
#import "YUDatePicker.h"

@interface LBCalculatorVC () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) NSArray *titleArr_1;
@property (nonatomic, strong) NSArray *placeHArr_1;
@property (nonatomic, strong) NSArray *titleArr_2;
@property (nonatomic, strong) NSArray *placeHArr_2;

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) NSDate *fromDate;
@property (nonatomic, strong) NSDate *toDate;
@property (nonatomic, strong) NSArray *weekDayArray;

@property (nonatomic, strong) YUDatePicker *datePicker;

@property (nonatomic, assign) CGFloat changeHeight; // 键盘调整高度
@property (nonatomic, assign) BOOL isKeyBoard;

@end

@implementation LBCalculatorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self addSomeView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)keyboardWillShow:(NSNotification *)notifi
{
    // 键盘的frame
//    CGRect keyboardF = [notifi.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    CGFloat height = keyboardF.size.height;
    if (kIPHONE_6s) {
        self.changeHeight = 60;
    }
    if (kIPHONE_5s) {
        self.changeHeight = 130;
    }
    if ([_textField isEqual:[self getTextFieldWithRow:5]] || [_textField isEqual:[self getTextFieldWithRow:6]]) {
        if (self.isKeyBoard == NO) {
            [self.scrollView setContentOffset:CGPointMake(0, self.scrollView.contentOffset.y + self.changeHeight) animated:YES];
        }
    }
    self.isKeyBoard = YES;
}
- (void)keyboardWillHide:(NSNotification *)notifi
{
    // 键盘的frame
//    CGRect keyboardF = [notifi.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    CGFloat height = keyboardF.size.height;
    if (self.isKeyBoard) {
        if (self.scrollView.contentOffset.y - self.changeHeight <= 0) {
            [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
            [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        }
        self.isKeyBoard = NO;
    }
}


- (void)addSomeView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.view addSubview:scrollView];
    scrollView.contentSize = CGSizeMake(kScreenWidth, 11 * 50 + 65 + 15+64);
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.backgroundColor = kBackgroundColor;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickComplete)];
    [scrollView addGestureRecognizer:tap];
    _scrollView = scrollView;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 - kJian64, kScreenWidth, 11 * 50 + 65) style:UITableViewStylePlain];
    [scrollView addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    _tableView = tableView;
    tableView.scrollEnabled = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 12;
}
// 未用重用机制
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < 7) {
        LBCaluTVCell_1 *cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([LBCaluTVCell_1 class]) owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.label.text = self.titleArr_1[indexPath.row];
        cell.textField.placeholder = self.placeHArr_1[indexPath.row];
        cell.textField.delegate = self;
        if (indexPath.row == 3) {
            self.fromDate = nil;
            cell.textField.text = [self stringWithDate:self.fromDate];
        } else if (indexPath.row == 4) {
            self.toDate = nil;
            cell.textField.text = [self stringWithDate:self.toDate];
        } else if (indexPath.row == 1) {
        } else if (indexPath.row == 2) {
        } else if (indexPath.row == 5) {
            cell.textField.text = [self dayCount];
            cell.textField.keyboardType = UIKeyboardTypeNumberPad;
        } else if (indexPath.row == 6) {
            cell.textField.text = @"";
        }
        return cell;
    } else if (indexPath.row == 7) {
        LBCaluTVCell_2 *cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([LBCaluTVCell_2 class]) owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setBtnBlock:^(NSInteger index) {
            if (index) { // 计算
                [self calclatorNow];
            } else { // 清除
                [self resetCalculator];
            }
        }];
        return cell;
    } else {
        LBCaluTVCell_3 *cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([LBCaluTVCell_3 class]) owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.label.text = self.titleArr_2[indexPath.row - 8];
        cell.textField.placeholder = self.placeHArr_2[indexPath.row - 8];
        cell.textField.userInteractionEnabled = NO;
        if (indexPath.row == 8) {
            [cell.btn setTitle:@"天" forState:UIControlStateNormal];
            [cell.btn setTitleColor:kDeepColor forState:UIControlStateNormal];
            [cell.btn setTitleColor:kDeepColor forState:UIControlStateHighlighted];
            [cell.btn setBackgroundImage:nil forState:UIControlStateNormal];
            [cell.btn setBackgroundImage:nil forState:UIControlStateHighlighted];
        } else {
            __weak typeof(cell) weakCell = cell;
            [cell setClickBtn:^{ // 点击计算
                NSString *money = weakCell.textField.text;
                LBCalcDetailVC *detailVC = [[LBCalcDetailVC alloc] init];
                detailVC.money = money;
                [self.navigationController pushViewController:detailVC animated:YES];
            }];
            [cell setLongPreBlock:^(NSString *string) {
                UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"复制成功" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                [self presentViewController:alertC animated:YES completion:nil];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [alertC dismissViewControllerAnimated:YES completion:nil];
                });
                UIPasteboard *pasB = [UIPasteboard generalPasteboard];
                pasB.string = string;
            }];
        }
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < 7) {
        return KCellH_1;
    } else if (indexPath.row == 7) {
        return KCellH_2;
    } else {
        return KCellH_3;
    }
}

- (UITextField *)getTextFieldWithRow:(NSInteger)row
{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]];
    if ([cell isKindOfClass:[LBCaluTVCell_1 class]]) {
        return ((LBCaluTVCell_1 *)cell).textField;
    } else if ([cell isKindOfClass:[LBCaluTVCell_3 class]]) {
        return ((LBCaluTVCell_3 *)cell).textField;
    } else {
        return nil;
    }
}

- (void)resetCalculator
{
    [self.tableView reloadData];
}
- (void)calclatorNow // 计算
{
    if ([self nilWithIndex:0]) {
        [self alertShowString:@"请输入票面金额"];
    } else if ([self nilWithIndex:1]) {
        [self alertShowString:@"请输入月利率"];
    } else if ([self nilWithIndex:2]) {
        [self alertShowString:@"请输入年利率"];
    } else if ([self nilWithIndex:4]) {
        [self alertShowString:@"贴现日期需早于到期日期"];
    } else if ([self nilWithIndex:5]) {
        [self alertShowString:@"请输入调整天数"];
    } else if ([self nilWithIndex:6]) {
        [self alertShowString:@"请输入每十万元手续费"];
    } else {
        // 1
        NSInteger num1 = [[self dayNumFromDateToDate] integerValue] + [[self getTextFieldWithRow:5].text integerValue];
        [self getTextFieldWithRow:8].text = [NSString stringWithFormat:@"%ld", num1];
        // 2
        CGFloat num2 = 100000 * [[self getTextFieldWithRow:2].text floatValue] / 100 / 360 * num1 + [[self getTextFieldWithRow:6].text floatValue];
        [self getTextFieldWithRow:9].text = [NSString stringWithFormat:@"%.2lf", num2];
        // 3
        CGFloat num3 = num2 * [[self getTextFieldWithRow:0].text floatValue] / 10;
        [self getTextFieldWithRow:10].text = [NSString stringWithFormat:@"%.2lf", num3];
        // 4
        CGFloat num4 = [[self getTextFieldWithRow:0].text floatValue] * 10000 - num3;
        [self getTextFieldWithRow:11].text = [NSString stringWithFormat:@"%.2lf", num4];
    }
}
- (void)alertShowString:(NSString *)str
{
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"" message:str preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alertC dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertC addAction:action];
    [self presentViewController:alertC animated:YES completion:nil];
}
- (BOOL)nilWithIndex:(NSInteger)index // 输入框空的返回YES
{
    if (index == 4) {
        if ([[self dayNumFromDateToDate] intValue] <= 0) {
            return YES;
        } else {
            return NO;
        }
    }
    
    UITextField *textF = [self getTextFieldWithRow:index];
    if (textF.text.length) {
        return NO;
    }
    return YES;
}
- (NSString *)dayNumFromDateToDate
{
    NSTimeInterval formN = [self.fromDate timeIntervalSince1970];
    NSTimeInterval toN = [self.toDate timeIntervalSince1970];
    NSTimeInterval value = toN - formN + 100;
    NSString *string = [NSString stringWithFormat:@"%ld", (NSInteger)(value / 86353.814673)];
    return string;
}
- (void)dateChanged:(id)sender{
    YUDatePicker * control = (YUDatePicker*)sender;
    if ([_textField isEqual:[self getTextFieldWithRow:3]]) {
        self.fromDate = control.date;
        UITextField *textF = [self getTextFieldWithRow:3];
        textF.text = [self stringWithDate:control.date];
    } else {
        self.toDate = control.date;
        UITextField *textF = [self getTextFieldWithRow:4];
        textF.text = [self stringWithDate:control.date];
        UITextField *textF_5 = [self getTextFieldWithRow:5];
        textF_5.text = [self dayCount];
    }
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _textField = textField;
    if ([textField isEqual:[self getTextFieldWithRow:3]]) {
        YUDatePicker *datePicker = self.datePicker;
        textField.inputView = datePicker;
        textField.inputAccessoryView = [self inputView];
        datePicker.date = self.fromDate;
    } else if ([textField isEqual:[self getTextFieldWithRow:4]]) {
        YUDatePicker *datePicker = self.datePicker;
        textField.inputView = datePicker;
        textField.inputAccessoryView = [self inputView];
        datePicker.date = self.toDate;
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *orgStr = textField.text;
    if ([string isEqualToString:@"."] && ([orgStr containsString:@"."] || orgStr.length == 0)) {
        return NO;
    }

    if (orgStr.length > 0) {
        if (string.length > 0) {
            orgStr = [orgStr stringByAppendingString:string];
        } else {
            orgStr = [orgStr substringToIndex:orgStr.length - 1];
        }
    } else {
        orgStr = [orgStr stringByAppendingString:string];
    }
    if ([textField isEqual:[self getTextFieldWithRow:1]]) { // 月
        UITextField *textYear = [self getTextFieldWithRow:2];
        CGFloat num = [orgStr floatValue] * 12 / 10;
        textYear.text = [NSString stringWithFormat:@"%.2lf", num];
    } else if ([textField isEqual:[self getTextFieldWithRow:2]]) { // 年
        UITextField *textMonth = [self getTextFieldWithRow:1];
        CGFloat num = [orgStr floatValue] / 12 * 10;
        textMonth.text = [NSString stringWithFormat:@"%.2lf", num];
    }
    return YES;
}

- (UIView *)inputView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 40)];
    view.backgroundColor = [UIColor whiteColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom normalColor:kNavBarColor highColor:kNavBarColor fontSize:18 target:self action:@selector(clickComplete) forControlEvents:UIControlEventTouchUpInside title:@"完成"];
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = kLineColor;
    [view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(view);
        make.height.mas_equalTo(1);
    }];
    [view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(view).offset(-15);
        make.centerY.mas_equalTo(view);
    }];
    return view;
}
- (void)clickComplete
{
    [self.view endEditing:YES];
}
- (NSString *)dayCount
{
    NSDate *date = self.toDate;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitWeekday |  NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour fromDate:date];
    if (components.weekday == 1) { // 日
        return [NSString stringWithFormat:@"%d", 4];
    } else if (components.weekday == 7) { // 六
        return [NSString stringWithFormat:@"%d", 5];
    } else { // 工作日
        return [NSString stringWithFormat:@"%d", 3];
    }
    
}
- (NSString *)stringWithDate:(NSDate *)date
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitWeekday |  NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour fromDate:date];
    
    NSString *weekStr = self.weekDayArray[(long)components.weekday - 1];
    
    NSDateFormatter *dateFor = [[NSDateFormatter alloc] init];
    [dateFor setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [dateFor stringFromDate:date];
    
    return [NSString stringWithFormat:@"%@ %@", dateStr, weekStr];
}

- (YUDatePicker *)datePicker
{
//    if (_datePicker == nil) {
        YUDatePicker *datePicker = [ [ YUDatePicker alloc] init];
        datePicker.datePickerMode = UIYUDatePickerModeDateYYYYMMDDHHmm;
        NSDate* minDate = [NSDate dateWithTimeIntervalSince1970:0];
        NSDate* maxDate = self.toDate;
        datePicker.minimumDate = minDate;
        datePicker.maximumDate = maxDate;
        datePicker.date = maxDate;
//        _datePicker = datePicker;
        [datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged ];
//    }
    return datePicker;
}

#pragma mark - 所有懒加载
- (NSArray *)titleArr_1
{
    if (_titleArr_1 == nil) {
        _titleArr_1 = @[@"票面金额(万元)", @"月利率(‰)", @"年利率(％)", @"贴现日期", @"到期日期", @"调整天数", @"每十万手续费"];
    }
    return _titleArr_1;
}
- (NSArray *)placeHArr_1
{
    if (_placeHArr_1 == nil) {
        _placeHArr_1 = @[@"输入金额", @"‰", @"%", @"-", @"-", @"异地通常为3天", @"0"];
    }
    return _placeHArr_1;
}
- (NSArray *)titleArr_2
{
    if (_titleArr_2 == nil) {
        _titleArr_2 = @[@"计息天数", @"每十万贴息", @"贴现利息", @"贴现金额"];
    }
    return _titleArr_2;
}
- (NSArray *)placeHArr_2
{
    if (_placeHArr_2 == nil) {
        _placeHArr_2 = @[@"0", @"0.00元", @"0.00元", @"0.00元"];
    }
    return _placeHArr_2;
}
- (NSDate *)fromDate
{
    if (_fromDate == nil) {
        _fromDate = [NSDate date];
    }
    return _fromDate;
}
- (NSDate *)toDate
{
    if (_toDate == nil) {
        NSDate *nowDate = [NSDate date];
//        NSTimeInterval timeCount = 3600 * 24 * 180;
        NSTimeInterval timeCount = 0;
        _toDate = [NSDate dateWithTimeInterval:timeCount sinceDate:nowDate];
    }
    return _toDate;
}
- (NSArray *)weekDayArray
{
    if (_weekDayArray == nil) {
        _weekDayArray = @[@"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六"];
    }
    return _weekDayArray;
}



@end






