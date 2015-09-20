//
//  EmoticonPackage.swift
//  EmoticonKeyBoard
//
//  Created by Jefferson on 15/9/12.
//  Copyright © 2015年 Jefferson. All rights reserved.
//

import UIKit

/// 表情包模型
class EmoticonPackage: NSObject {
    
    /// 目录名
    var id: String?
    
    /// 分组名
    var group_name_cn: String?
    
    /// 表情符号数组
    lazy var emoticons = [Emoticon]()
    
    init(dict: [String: AnyObject]) {
        super.init()
        id = dict["id"] as? String
        group_name_cn = dict["group_name_cn"] as? String
        
        var index = 0
        if let array = dict["emoticons"] as? [[String: String]] {
            /// 循环创建emoticon 数组
            for var dic in array {
                
                if let imagePath = dic["png"] {
                    // 修改字典路径
                    dic["png"] = id! + "/" + imagePath
                }
                emoticons.append(Emoticon(dict: dic))
                
                index++
                // 判断是否已经20个
                if index == 20 {
                    // 插入一个删除按钮
                    emoticons.append(Emoticon(isRemove: true))
                    // 让计数复位
                    index = 0
                    
            }
        }
            appendBlankEmoticon()
    }
}
        /// 追加空白表情
        func appendBlankEmoticon() {
            let count = emoticons.count % 21
            
            print("\(group_name_cn)分组 剩余 \(count) 个 按钮")
            // 如果刚好被 21 整除直接返回
            if count == 0 && emoticons.count > 0  {
                return
            }
            
            // 如果有需要补足的情况，表情数组完全为空
            // 追加到20个空白按钮
            for _ in count..<20 {
                emoticons.append(Emoticon(isEmpty: true))
            }
            
            // 末尾追加一个删除按钮
            emoticons.append(Emoticon(isRemove: true))
        }
}
