//
//  LYBLuncollectionview.swift
//  DriveHome
//
//  Created by lambo on 2021/1/31.
//无线轮播要关注的几个问题：滚动到边界的时候怎么处理；自动轮播定时器逻辑怎么设置；
//这里是定时器销毁的做法，可以延迟执行，有瑕疵，但是和其他几种方式比，内存占用稍微低一些
//UICollectionview，定时器自动无限轮播，有动画
import UIKit

let lunbocellidentifier="LYBLunboCollectionViewCell"
class LYBLuncollectionview: UIView,UICollectionViewDelegate,UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:LYBLunboCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: lunbocellidentifier, for: indexPath) as! LYBLunboCollectionViewCell
                cell.backgroundColor=UIColor.red
        cell.imagestr=imageArr[indexPath.item]
        return cell
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled=true
        addSubview(collectionv)
        //先默认滚动到第二组第一个
        collectionv.scrollToItem(at: IndexPath.init(item: 0, section: 1) as IndexPath, at: UICollectionView.ScrollPosition.right, animated: false)
        addSubview(pagectr)
        setTimer()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var imageArr:[String]=["lunboone"]
    var index:Int=4  //定时器执行滚动的索引，默认是第二组第一个的索引
    var imageList:[String]=[]{
        didSet{
            print("数组\(imageList)")
            imageArr=imageList
            index=imageList.count
            pagectr.numberOfPages=imageList.count;
            collectionv.reloadData()
            collectionv.scrollToItem(at: IndexPath.init(item: 0, section: 1) as IndexPath, at: UICollectionView.ScrollPosition.right, animated: false)
        }
    }
   
    var section:Int=0//当前的组
    var row:Int=0//当前的cell
    var timer:Timer?
    var intervtim:Double = 4 //定时器周期
    var delaytime:Double=4//延迟执行定时器的时间
    var isDrag:Bool=false//是否拖拽
    var lastOffset:CGFloat=0//上一次的偏移量
    var derectStr:String="right"//方向字符串---暂时没有用到
    var firstsec:TimeInterval=0;//初始时间--为了控制手动拖拽后多久启动定时器
    var secsec:TimeInterval=0;//现在的时间
    func setTimer(){
        timer = Timer.scheduledTimer(timeInterval:TimeInterval(intervtim), target: self, selector: #selector(timerrun), userInfo: nil, repeats: true)
        //common里面包含defaultmode和trackongmode，拖动scrollview的时候就变成tracking，不拖动了就是defultmode，trackongmode的优先级高于default，使用common，两种模式可以自由切换,
          RunLoop.main.add(timer!, forMode: RunLoop.Mode.common)
//           timer?.fire()// 立即执行定时器
    }
    
@objc  func timerrun(){
    print("第\(index)个cell")
       //1套方案，不停的创建定时器，销毁定时器，这个不太好，但是内存也不会增长
        collectionv.setContentOffset(CGPoint.init(x: Int(WIDTH)*index, y: 0), animated: true)
        lastOffset=collectionv.contentOffset.x//记录上一次的偏移，用来判断滚动方向
        pagectr.currentPage=index%imageArr.count
        //到达第三组第一个，取消定时器，静默就滚动到第二组第一个（千万不要带动画），索引重置
        if index==imageArr.count*2{
            timerInvalide()
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+TimeInterval(delaytime)) { [weak self] in
                self!.collectionv.scrollToItem(at: IndexPath.init(item: 0, section: 1) as IndexPath, at: UICollectionView.ScrollPosition.right, animated: false)
                self!.index=self!.imageArr.count//把索引重置到第二组第一个
                self!.index+=1//本身就在第二组第一个，所以重启定时器的时候要滚动到下一个（为了能连续滚动），所以这里要+1

                if self!.isDrag==false{//拖拽的时候定时器停止，找个合适的时间吧这个状态重置为false，才可以重新开启定时器
                   self!.setTimer()//重新创建定时器
                   }

                    }
    }else{
            timerInvalide()
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+TimeInterval(delaytime)) { [weak self] in

                if self!.isDrag==false{
                    self!.setTimer()//重新创建定时器
                  }
                   }
                index+=1
          }
    }
    
   //停止定时器
    func timerInvalide(){
        if timer != nil{
        timer?.invalidate()
        timer=nil
        }
    }
    
    lazy var collectionv:UICollectionView={
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.itemSize=CGSize.init(width: WIDTH, height: 200)
        flowLayout.minimumLineSpacing=0
        flowLayout.minimumInteritemSpacing=0
        flowLayout.scrollDirection = .horizontal
        var collec:UICollectionView?
        collec = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: WIDTH, height: 200), collectionViewLayout: flowLayout)
        collec?.showsHorizontalScrollIndicator=false
        collec?.showsVerticalScrollIndicator=false
        collec?.backgroundColor=UIColor.white
        collec?.isPagingEnabled=true
        collec?.delegate=self
        collec?.dataSource=self
        collec?.isScrollEnabled=true
        collec?.register(LYBLunboCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: lunbocellidentifier)
        return collec!
    }()
    lazy var pagectr:UIPageControl={
        let pagectr:UIPageControl!
        pagectr=UIPageControl.init(frame: CGRect.init(x: 50, y: 180-30, width: Int(WIDTH-100), height: 30))
        pagectr?.numberOfPages=3
        pagectr?.pageIndicatorTintColor=UIColor.gray
        pagectr?.currentPageIndicatorTintColor=UIColor.red
        pagectr.hidesForSinglePage=true
        pagectr?.currentPage=0
      return pagectr
    }()
    
    }

extension LYBLuncollectionview{
   
    //正在滚动,判断是左移还是右移
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
     
        //和上一次的偏移量做比较，判断滑动的方向
        if scrollView.contentOffset.x > lastOffset{
             derectStr="left"
        }else{
             derectStr="right"
        }
    }
    
    //获取当前的组合cell
    func getSectionAndcell(){
        // 将collectionView在控制器view的中心点转化成collectionView上的坐标
        let pInView:CGPoint=self.convert(collectionv.center, to: collectionv)
        // 获取这一点的indexPath
        let indexpath = collectionv.indexPathForItem(at: pInView)
        section=indexpath!.section
        row=indexpath!.item
    }
    
    //手指在屏幕上开始拖拽
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
       timerInvalide()
       isDrag=true//标记为拖拽就不会创建定时器
        print("定时器停止")
        firstsec = NSDate().timeIntervalSince1970//当前时间
        lastOffset=collectionv.contentOffset.x  //吧当前偏移量记录下来，作为上一次的偏移，用来判断滚动方向
        //开始拖拽的时候就默认滚动到第二组
         //第一组滚动到第二组
         if lastOffset<CGFloat(imageArr.count)*WIDTH{
             collectionv.setContentOffset(CGPoint.init(x: lastOffset+CGFloat(imageArr.count)*WIDTH, y: 0), animated: false)
         }
         //第三组滚动到第二组
         if(lastOffset>CGFloat(imageArr.count)*WIDTH*2){
             collectionv.setContentOffset(CGPoint.init(x: lastOffset-CGFloat(imageArr.count)*WIDTH, y: 0), animated: false)
         }


       
    }
    
   
    
    //停止拖拽，手指离开了屏幕，如果当前cell一半已经离开屏幕，就朝着多的方向滚动，直到整个cell滚动出屏幕
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
     
        lastOffset=collectionv.contentOffset.x  //吧当前偏移量记录下来，作为上一次的偏移，用来判断滚动方向
       let ishalf=lastOffset/WIDTH-floor(lastOffset/WIDTH)
        if ishalf>0.5{
            if derectStr=="right"{
                if section==0{
                    collectionv.setContentOffset(CGPoint.init(x: (floor(lastOffset/WIDTH)+1)*WIDTH+CGFloat(imageArr.count)*WIDTH, y: 0), animated: false)
                }
                if(section==2){
                    collectionv.setContentOffset(CGPoint.init(x: (floor(lastOffset/WIDTH)-1)*WIDTH-CGFloat(imageArr.count)*WIDTH, y: 0), animated: false)
                }
            }else {
                
            }
        }
    }
    
    //手动拖拽，手指离开了屏幕，滚动的cell停止加速度,减速完成(滚动停止)
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        /*获取当前的cell的Indexpath,这种方法获取Indexpath,会导致cell的位置不准确，
        即使我的cell大小等于collectionView的大小,在[collectionView indexPathsForVisibleItems]方法得到的数组数据也有可能大于一个，并且顺序还不一定,导致我也不能通过firstObject或者lastObject来获取我想要的值
        */
//        let indexpath =  collectionv.indexPathsForVisibleItems.first
        
        //获取section和row
        getSectionAndcell()
        print("row----\(String(describing: row))")
        //如果在第一组和第三组就默认滚动到第二组相应的cell
        if section==0||section==2{
            if derectStr=="right"{
            collectionv.scrollToItem(at: IndexPath.init(item:row, section: 1), at: UICollectionView.ScrollPosition.right, animated: false)
            }else {
                collectionv.scrollToItem(at: IndexPath.init(item:row, section: 1), at: UICollectionView.ScrollPosition.left, animated: false)
            }
            section=1
        }
        
        index=imageArr.count+row//定时器执行滚动的索引
        print("\(index)---组\(section)-\(String(describing: row))---\(Int(collectionv.contentOffset.x/WIDTH))")
        pagectr.currentPage=index%imageArr.count
        lastOffset=collectionv.contentOffset.x  //记录上一次的偏移，用来判断滚动方向
       
        
        
        isDrag=false
        secsec = NSDate().timeIntervalSince1970//当前时间,距离1970年的时间
        print("相差的时间\(secsec-firstsec)")
//        这个是开始拖拽到松开后的时间差，如果已经大于定时器延时的时间，就要重新开启定时器
        if secsec-firstsec>delaytime{
            timerrun()
        }
       
    }
    
    //停止滚动,自动滚动才执行，手势拖拽后停下来，这个方法不会执行
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        print("停止滚动")
        getSectionAndcell()
        //index是在第七个cell停止下来的时候，就已经变成第八个cell的索引
        if index==imageArr.count*2{//如果在第三组，默认滚动到第一组，上面的定时器正好可以加上动画
        collectionv.scrollToItem(at: IndexPath.init(item: row, section: 0) as IndexPath, at: UICollectionView.ScrollPosition.right, animated: false)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("点击\(indexPath.item)")
    }
    
}
