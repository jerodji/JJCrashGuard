//
//  ViewController.m
//  CrashDemo
//
//  Created by Jerod on 2021/5/17.
//

#import "ViewController.h"
#import "CFuns.hpp"
#import <JJCrashGuard/JJCrashGuard.h>


@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor systemPinkColor];
    
//    // open crash prevent
//    [[JJCrashGuard shared] beginGuard];
//    [[JJCrashGuard shared] beginGuardTypes:JShieldTypeArray];

//    // open assert to help debug, it's not work on release
//    [[JJCrashGuard shared] openDebuggerAssert:YES];
        
    [self.view addSubview:self.tableView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [[JJCrashGuard shared] beginGuardTypes:JShieldTypeDictionary];

}


- (NSArray*)names {
    return @[
        @"NSArray",
        @"NSMutableArray",
        @"NSDictionary",
        @"NSMutableDictionary",
        @"KVC"
    ];
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"cell_id"];
    }
    return _tableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self names].count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_id"];
    cell.textLabel.text = [self names][indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * n = [self names][indexPath.item];
    if ([n isEqualToString:@"NSArray"]) {
        NSArray * arr = @[@1, @2];
        id obj1 = arr[5];
        id obj = [arr objectAtIndex:3];
    }
    if ([n isEqualToString:@"NSMutableArray"]) {
//        NSMutableArray *mut = [NSMutableArray arrayWithArray:@[@0,@1]];//__NSArrayM
//        NSMutableArray *mut = [NSMutableArray arrayWithArray:@[@0]];//__NSArrayM
//        NSMutableArray *mut = [NSMutableArray array];//__NSArrayM
//        NSMutableArray *mut = [[NSMutableArray alloc] init];//__NSArrayM
        NSMutableArray *mut = [NSMutableArray arrayWithCapacity:1];//__NSArrayM
        NSLog(@"%@", mut.class);
//        id el = [mut objectAtIndex:7];
//        id nu = mut[113];
//        [mut insertObject:nil atIndex:3];
    }
    if ([n isEqualToString:@"NSDictionary"]) {
        NSDictionary *dic = [NSDictionary dictionary];//__NSDictionary0
//        NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:nil, nil, nil];
//        id obj = nil;
//        NSDictionary *dic = [[NSDictionary alloc] initWithObjects:@[@1, obj] forKeys:@[@"a", @"b"]];
//        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:nil];
//        NSDictionary *dic = [[NSDictionary alloc] initWithDictionary:@{@"s": @"1"}];
//        NSDictionary *dic = [NSDictionary alloc];
        NSLog(@"%@", dic.class);
        NSString *key = nil;
        id v1 = [dic objectForKey:key];
        id v2 = dic[key];
//        dic[@"key"] = @"key";
//        dic = @{
//            @"ko": @1
//        };
//        dic[@"s"] = @"q";
//        id vv = [dic objectForKey:@"kk"];
//        id vv = dic[@"kk"];
//        NSLog(@"%@", vv);
//        [dic setValue:nil forKey:@"ko"];
//        [dic valueForKey:@"ll"];
//       id d = [dic initWithObjects:nil forKeys:nil];
//        NSLog(@"%@", d);
    }
    if ([n isEqualToString:@"NSMutableDictionary"]) {
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];//__NSDictionaryM
        NSLog(@"%@", dic.class);
        [dic setValue:@"1" forKey:@"11"];
        [dic setObject:@"po" forKey:@"po"];
//        [dic setObject:nil forKey:@"pp"];
//        [dic setObject:@"oo" forKey:nil];
        [dic setObject:nil forKeyedSubscript:@"oo"];
//        [dic setObject:@"qq" forKeyedSubscript:nil];
        [dic objectForKey:@"22"];
        dic[@"99"];
        dic[@"33"] = [NSNull null];
        dic[@"44"] = nil;
        dic[@"100"] = @100;
        NSString * k101 = nil;
//        dic[k101] = @101;
        NSLog(@"%@", dic);
        [dic removeObjectsForKeys:@[@"66"]];
        [dic removeObjectsForKeys:@[@"11", @"22", @"55"]];
        [dic removeObjectForKey:@"77"];
//        [dic removeObjectForKey:nil];
        [dic removeAllObjects];
    }
    if ([n isEqualToString:@"KVC"]) {
        NSObject *obj = [NSObject new];
//        [obj setValue:@1 forKey:@"uk"];
        [obj valueForKey:@"uu"];
    }
}


//- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    ccfuns(22);
//}


@end
