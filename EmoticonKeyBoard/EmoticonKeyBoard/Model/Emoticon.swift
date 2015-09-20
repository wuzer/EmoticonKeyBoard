//
//  Emoticon.swift
//  EmoticonKeyBoard
//
//  Created by Jefferson on 15/9/12.
//  Copyright © 2015年 Jefferson. All rights reserved.
//

import UIKit

/// 表情符号模型
class Emoticon: NSObject {
    
    /// 表情文字
    var chs: String?
    
    /// 表情图片
    var png: String?
    /// 图像的完整路径
    var imagePath: String {
        return (png != nil) ? NSBundle.mainBundle().bundlePath + "/Emoticons.bundle/" + png! : ""
    }
    
    /// emoji 编码
    var code: String? {
        didSet {
            // 读取 16 进制的数值
            let scanner = NSScanner(string: code!)
            
            var value: UInt32 = 0
            scanner.scanHexInt(&value)
            
            emoji = String(Character(UnicodeScalar(value)))
        }
    }
    
    /// emiji 字符串
    var emoji: String?
    /// 删除按钮标记
    var isRemove = false
    /// 空白按钮标记
    var isEmpty = false
    
    init(isEmpty: Bool) {
        super.init()
        
        self.isEmpty = isEmpty
    }
    
    init(isRemove: Bool) {
        super.init()
        
        self.isRemove = isRemove
    }
    
    /// 构造函数
    init(dict: [String: String]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    /// 字典转模型缺失
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
    /// 说明
    override var description: String {
        let keys = ["chs", "png", "code", "isRemove", "isEmpty"]
        
        return dictionaryWithValuesForKeys(keys).description
    }
}
