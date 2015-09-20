//
//  EmoticonViewController.swift
//  EmoticonKeyBoard
//
//  Created by Jefferson on 15/9/12.
//  Copyright © 2015年 Jefferson. All rights reserved.
//

import UIKit

/// 可重用标示符
private let EmoticonCellID = "EmoticonCellID"
/// 表情键盘控制器
class EmoticonViewController: UIViewController {
    
    // MARK: - 监听方法
    @objc private func clickItem(item: UIBarButtonItem) {
        let indexPath = NSIndexPath(forRow: 0, inSection: item.tag)
        
        collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: UICollectionViewScrollPosition.Left, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.redColor()
        
        viewModel.loadPackages()
        setupUI()
    }
    
    // MARK: - 设置界面
    private func setupUI() {
        // 添加控件
        view.addSubview(collectionView)
        view.addSubview(toolBar)
        
        // 设置布局
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        
        let viewDict = ["view": collectionView, "bar": toolBar]
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[view]-0-|", options: [], metrics: nil, views: viewDict))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[bar]-0-|", options: [], metrics: nil, views: viewDict))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[view]-[bar(44)]-0-|", options: [], metrics: nil, views: viewDict))
        
        // 准备控件
        prepareToolBar()
        prepareCollectionView()
    }
    
    // MARK: - 准备工具栏
    private func prepareToolBar() {
        toolBar.tintColor = UIColor.darkGrayColor()
        
        var items = [UIBarButtonItem]()
        var index = 0
        
        for title in ["最近", "默认", "emoji", "浪小花"] {
            items.append(UIBarButtonItem(title: title, style: UIBarButtonItemStyle.Plain, target: self, action: "clickItem:"))
            items.last?.tag = index++
            
            items.append(UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil))
        }
        items.removeLast()
        toolBar.items = items
    }
    
    // MARK: - 准备collectionView
    private func prepareCollectionView() {
        // 注册cell
        collectionView.registerClass(EmoticonCell.self, forCellWithReuseIdentifier: EmoticonCellID)
        collectionView.backgroundColor = UIColor.whiteColor()
        
        collectionView.dataSource = self
    }
    
    
    // MARK: - 懒加载控件
    /// 工具栏
    private lazy var toolBar =  UIToolbar()
    /// collectionView
    private lazy var collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: EmoticonLayout())
    /// 表情包的师徒模型
    private lazy var viewModel = EmoticonViewModel()
}

// MARK: - 表情键盘的布局
private class EmoticonLayout: UICollectionViewFlowLayout {
    
    private override func prepareLayout() {
        super.prepareLayout()
        
        let width = collectionView!.bounds.width / 7
        
        let margin = (collectionView!.bounds.height - width * 3) * 0.499
        
        itemSize = CGSize(width: width, height: width)
        minimumInteritemSpacing = 0
        minimumLineSpacing = 0
        
        sectionInset = UIEdgeInsets(top: margin, left: 0, bottom: margin, right: 0)
        
        scrollDirection = UICollectionViewScrollDirection.Horizontal
        
        collectionView?.pagingEnabled = true
        collectionView?.showsHorizontalScrollIndicator = false
    }
}

// MARK: - UICollectionViewDataSource
extension EmoticonViewController: UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return viewModel.packages.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.packages[section].emoticons.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(EmoticonCellID, forIndexPath: indexPath) as! EmoticonCell
        
        cell.emoticon = viewModel.emoticon(indexPath)
        return cell
    }
}

// MARK: - 表情cell
private class EmoticonCell: UICollectionViewCell {
    
    var emoticon: Emoticon? {
        didSet {
            // 以下两个清空的动作，能够解决重用的问题
            // 1. 图片 - 如果没有会清空图片
            EmoticonButton.setImage(UIImage(contentsOfFile: (emoticon?.imagePath)!), forState: UIControlState.Normal)
            // emoji
            EmoticonButton.setTitle(emoticon?.emoji, forState: UIControlState.Normal)
            // 删除按钮
            if emoticon!.isRemove {
                EmoticonButton.setImage(UIImage(named: "compose_emotion_delete"), forState: UIControlState.Normal)
                EmoticonButton.setImage(UIImage(named: "compose_emotion_delete_highlighted"), forState: UIControlState.Highlighted)
            }
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(EmoticonButton)
        EmoticonButton.backgroundColor = UIColor.whiteColor()
        EmoticonButton.frame = CGRectInset(bounds, 4, 4)
        EmoticonButton.titleLabel?.font = UIFont.systemFontOfSize(32)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 懒加载控件
    private lazy var EmoticonButton: UIButton = UIButton()
    
}




