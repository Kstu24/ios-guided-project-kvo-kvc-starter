//
//  ViewController.m
//  KVO KVC Demo
//
//  Created by Paul Solt on 4/9/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

#import "ViewController.h"
#import "LSIDepartment.h"
#import "LSIEmployee.h"
#import "LSIHRController.h"


@interface ViewController ()

@property (nonatomic) LSIHRController *hrController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    LSIDepartment *marketing = [[LSIDepartment alloc] init];
    marketing.name = @"Marketing";
    LSIEmployee *philSchiller = [[LSIEmployee alloc] init];
    philSchiller.name = @"Phil";
    philSchiller.jobTitle = @"VP of Marketing";
    philSchiller.salary = 10000000;
    marketing.manager = philSchiller;
    
    
    LSIDepartment *engineering = [[LSIDepartment alloc] init];
    engineering.name = @"Engineering";
    LSIEmployee *craig = [[LSIEmployee alloc] init];
    craig.name = @"Craig";
    craig.salary = 9000000;
    craig.jobTitle = @"Head of Software";
    engineering.manager = craig;
    
    LSIEmployee *e1 = [[LSIEmployee alloc] init];
    e1.name = @"Chad";
    e1.jobTitle = @"Engineer";
    e1.salary = 200000;
    
    LSIEmployee *e2 = [[LSIEmployee alloc] init];
    e2.name = @"Lance";
    e2.jobTitle = @"Engineer";
    e2.salary = 250000;
    
    LSIEmployee *e3 = [[LSIEmployee alloc] init];
    e3.name = @"Joe";
    e3.jobTitle = @"Marketing Designer";
    e3.salary = 100000;
    
    [engineering addEmployee:e1];
    [engineering addEmployee:e2];
    [marketing addEmployee:e3];
    
    LSIHRController *controller = [[LSIHRController alloc] init];
    [controller addDepartment:engineering];
    [controller addDepartment:marketing];
    self.hrController = controller;
    
    
    
#pragma Key Value (KVC)
    //    NSString *key = @"privateName";
    //
    //    [craig setValue:@"Hair Force One" forKey:key];
    //
    //    NSString *value = [craig valueForKey:key]; // Can't use craig.privateName
    //    NSLog(@"Value for key %@: %@", key, value);
    
    //    for (id employee in engineering.employees) {
    //        NSString *value = [employee valueForKey:key];
    //        NSLog(@"Value for key %@: %@", key, value);
    //    }
    
    //    value = [philSchiller valueForKey:key];
    //    NSLog(@"Before: %@: %@", key, value);
    //    [philSchiller setValue:@"Apple fellow" forKey:key];
    //    value = [philSchiller valueForKey:key];
    //    NSLog(@"After: %@: %@", key, value);
    
#pragma Key path
    
    [marketing addEmployee:craig];
    
    NSLog(@"%@", self.hrController);
    
    NSString *keyPath = @"departments.@distinctUnionOfArrays.employees";
    NSString *allEmployees = [self.hrController valueForKeyPath:keyPath];
    NSLog(@"Employee's name: %@", allEmployees);
    
    //    [marketing setValue:@(75000) forKeyPath:@"manager.salary"];
    
    NSLog(@"Average salary: %@", [allEmployees valueForKeyPath:@"@avg.salary"]);
    NSLog(@"Max salary: %@", [allEmployees valueForKeyPath:@"@max.salary"]);
    NSLog(@"Minimum salary: %@", [allEmployees valueForKeyPath:@"@min.salary"]);
    NSLog(@"Number of salaries: %@", [allEmployees valueForKeyPath:@"@count.salary"]);
    
    @try {
        NSArray *directSalaries = [self valueForKeyPath:@"hrController.departments.@unionOfArrays.employees.salary"];
        NSLog(@"Direct salaries: %@", directSalaries);
    } @catch (NSException *exception) {
        NSLog(@"Got an exception: %@", exception);
    }
    
    
}


@end
