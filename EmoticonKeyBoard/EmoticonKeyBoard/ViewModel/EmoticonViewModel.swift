//
//  EmoticonViewModel.swift
//  EmoticonKeyBoard
//
//  Created by Jefferson on 15/9/12.
//  Copyright © 2015年 Jefferson. All rights reserved.
//

import UIKit

/// 表情的视图模型 -> 加载表情数据
/**
从 Emoticons.bundle 中读取 emoticons.plist
遍历 packages 数组，创建 EmoticonPackage 的数组

EmoticonPackage 的明细内容从 id 对应的目录加载 info.plist 完成字典转模型
*/

class EmoticonViewModel: NSObject {
    
    /// 表情包的数组
    lazy var packages = [EmoticonPackage]()
    
    /// 加载表情包
    func loadPackages() {
        
        // 最近表情包
        packages.append(EmoticonPackage(dict: ["group_name_cn": "最近"]))
        
        // 读取emoticon.plist
        let path = NSBundle.mainBundle().pathForResource("emoticons.plist", ofType: nil, inDirectory: "Emoticons.bundle")
        
        // 读取字典
        let dict = NSDictionary(contentsOfFile: path!)
        
        // 读取 package 数组
        let array = dict!["packages"] as! [[String: AnyObject]]
        
        // 遍历数组,创建模型
        for infoDict in array {
            
            // 获取 id
            let id = infoDict["id"] as! String
            // 拼接路径
           let emPath = NSBundle.mainBundle().pathForResource("info.plist", ofType: nil, inDirectory: "Emoticons.bundle/" + id )
            
            // 加载字典
            let packageDict = NSDictionary(contentsOfFile: emPath!) as! [String: AnyObject]
            
            // 字典转模型
            packages.append(EmoticonPackage(dict: packageDict))
            
        }
    }
    
    func emoticon(indexPath: NSIndexPath) -> Emoticon {
        return packages[indexPath.section].emoticons[indexPath.item]
    }
}
