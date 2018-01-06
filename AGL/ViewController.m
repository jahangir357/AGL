//
//  ViewController.m
//  AGL
//
//  Created by Jahangir on 6/1/18.
//  Copyright © 2018 Jahangir. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize maleView,femaleView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL * url=[NSURL URLWithString:@"http://agl-developer-test.azurewebsites.net/people.json"];   // pass your URL  Here.
    
    NSData * data=[NSData dataWithContentsOfURL:url];
    
    NSError * error;
    
    NSMutableDictionary  * json = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error];
    
    NSMutableArray * femaleArr=[[NSMutableArray alloc]init];
    
    NSMutableArray * maleArr=[[NSMutableArray alloc]init];
    
    NSArray * responseArr = json;
    if([responseArr count] > 0){
        for(NSDictionary * dict in responseArr)
        {
            if([[dict valueForKey:@"gender"] isEqualToString:@"Female"]){
                
                if([dict valueForKey:@"pets"] != (id)[NSNull null]){
                    NSArray * responsePetsArr = [dict valueForKey:@"pets"];
                    for(NSDictionary * petsDic in responsePetsArr)
                    {
                        [femaleArr addObject:[petsDic valueForKey:@"name"]];
                    }
                }
            }else if([[dict valueForKey:@"gender"] isEqualToString:@"Male"]){
                
                if([dict valueForKey:@"pets"] != (id)[NSNull null] ){
                    NSArray * responsePetsArr = [dict valueForKey:@"pets"];
                    for(NSDictionary * petsDic in responsePetsArr)
                    {
                        [maleArr addObject:[petsDic valueForKey:@"name"]];
                    }
                }
            }
            
        }
    }
    
    femaleView.text = [femaleArr componentsJoinedByString:@"\n"];
    maleView.text = [maleArr componentsJoinedByString:@"\n"];
    NSLog(@"%@",femaleArr);   // Here you get the Referance data
    NSLog(@"%@",maleArr);      // Here you get the Period data

    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
