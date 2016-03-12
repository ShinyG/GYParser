# GYParser
* 一个字典转模型的轻量级小框架.
* 简单易用，简洁便携，一行代码搞定所有。

### Tips：
* 1.该框架在解析时把所有基本数据类型转换成了字符串,再也不用去一个个去看字段的类型了。
* 2.在解析时已经对NULL、nil作了处理，再也不用担心因为使用到解析出来的空值而有可能导致的crash了。

#GYParser的使用
* 方法一:通过cocoapods -> pod 'GYParser'
* 方法二:Download ZIP -> 把GYParser文件夹中的所有文件拽入项目中,导入NSObject+GYParse头文件即可使用


## 1.最简单的字典转模型
```objc
   		NSDictionary *dic1 = @{@"name":@"张三",@"age":@18,@"icon":@"icon.png",@"sex":@(Male)};
   		NSLog(@"1. %@",[Person gy_parseWithDic:dic1]);
```

## 2.模型中有模型
```objc
	    NSDictionary *dic2 = @{@"name":@"张三",@"age":@18,@"icon":@"icon.png",@"sex":@(Male),
                               @"pet" : @{@"name":@"旺财",@"age":@2,
                                          @"food":@{
                                                  @"name":@"fish"
                                                  }
                                          }
                               };
        NSLog(@"2. %@",[Person gy_parseWithDic:dic2]);
```

## 3.模型中的属性名和字典中的key名不同
```objc
        NSDictionary *dic3 = @{@"name":@"张三",@"age":@18,@"icon":@"icon.png",@"sex":@(Male),
                               @"pet" : @{@"name":@"旺财",@"age":@2,
                                          @"food":@{
                                                  @"name":@"fish"
                                                  }
                                          },
                               @"transport": @{@"name":@"car",@"money":@(1000000)}
                               };
        NSLog(@"3. %@",[Person gy_parseWithDic:dic3]);
```

## 4.模型中有数组属性，数组的成员是自定义模型，并且数组的名字与key不同
```objc
        NSArray *skills = @[@{@"name":@"寒冰箭"},@{@"name":@"火焰冲击"},@{@"name":@"奥数飞弹"}];
        NSDictionary *dic4 = @{@"name":@"张三",@"age":@18,@"icon":@"icon.png",@"sex":@(Male),
                               @"pet" : @{@"name":@"旺财",@"age":@2,
                                          @"food":@{
                                                  @"name":@"fish"
                                                  }
                                          },
                               @"transport": @{@"name":@"car",@"money":@(1000000)},
                               @"sks":skills
                               };
        NSLog(@"4. %@",[Person gy_parseWithDic:dic4]);
```

## 5.将字典数组转成模型数组
```objc
        NSArray *sks = [Skill gy_parseWithArrayDic:skills];
        for (int i = 0; i < sks.count; i++) {
            NSLog(@"5. %@,%@",[sks[i] class],[sks[i] name]);
        }
```

## 6.解析plist文件,二维数组->模型
```objc
        NSArray *goodModel = [GoodsModel gy_parseWithPlist:@"List"];
        for (int i = 0; i < goodModel.count; i++) {
            for (int j = 0; j < [goodModel[i] count]; j++) {
                NSLog(@"6. [%d][%d]%@",i,j,goodModel[i][j]);
            }
        }
```
        
