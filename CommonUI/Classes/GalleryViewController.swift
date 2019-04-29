//
//  GalleryViewController.swift
//  CommonUI
//
//  Created by Massimiliano on 05/11/2018.
//

import UIKit
open class GalleryCell: UICollectionViewCell {
    
    public var imageView: ImageViewZoomable = ImageViewZoomable()
   
    public func prepare() {
        if self.imageView.superview == nil {
            self.contentView.add(subview: self.imageView, margin: .zero)
        }

    }
}

open class GalleryViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
  
    /**
     Update the content of an item
    */
    public var configureItem: ((_ item: GalleryCell, _ index: IndexPath) -> ())?
    public var didSelectItem: ((_ item: GalleryCell, _ index: IndexPath) -> ())?
    public var numberOfItem: Int = 0 { didSet { } }
    public var backgroundView: UIView?
    public var collectionView: UICollectionView?
    public var cellClass: AnyClass = GalleryCell.self
    
    private var cellId: String = "Cell"
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    
    /**
     Initialize all UI Elements
     */
    open func setupUI() {
        self.view.backgroundColor = UIColor.clear
        self.view.isOpaque = false
        
        self.backgroundView = UIView(frame: view.bounds)
        self.backgroundView?.backgroundColor = UIColor.black
        self.backgroundView?.alpha = 0
        self.view.add(subview: self.backgroundView!, margin: .zero)

        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.minimumInteritemSpacing = 0
        collectionViewLayout.minimumLineSpacing = 0
        collectionViewLayout.scrollDirection = .horizontal
        
        self.collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: collectionViewLayout)
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        self.collectionView?.isPagingEnabled = true
        self.collectionView?.register(self.cellClass, forCellWithReuseIdentifier: self.cellId)
        self.view.add(subview: self.collectionView!, margin: .zero)
        self.collectionView?.reloadData()
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.numberOfItem
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellId, for: indexPath) as! GalleryCell
        cell.prepare()
        self.configureItem?(cell,indexPath)
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.view.bounds.size
        
    }
    
}





public class ImageViewZoomable: UIScrollView, UIScrollViewDelegate {
    
    var imageView: UIImageView = UIImageView(image: nil)
    public var image: UIImage? { set { self.imageView.image = newValue} get { return self.imageView.image}}

    public init() {
        super.init(frame: .zero)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }
    
    func setupView() {
        self.delegate = self
        self.imageView.contentMode = .scaleAspectFit
        self.imageView.backgroundColor = .clear
        self.imageView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        self.imageView.frame = self.bounds
        self.addSubview(self.imageView)
        
        self.backgroundColor = .clear
        self.minimumZoomScale = 1
        self.maximumZoomScale = 2
   
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(self.doubleTapAction))
        doubleTap.numberOfTapsRequired = 2
        self.addGestureRecognizer(doubleTap)
    }
    
    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
 
    @objc func doubleTapAction() {
        if self.zoomScale == 1 {
            self.setZoomScale(2, animated: true)
        } else {
            self.setZoomScale(1, animated: true)
        }
    }
    
}
