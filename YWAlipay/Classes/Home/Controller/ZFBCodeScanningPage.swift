//
//  ZFBCodeScanningPage.swift
//  AlipayProject
//
//  Created by Mac on 2017/4/5.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class ZFBCodeScanningPage: UIViewController , UIImagePickerControllerDelegate ,UINavigationControllerDelegate, AVCaptureMetadataOutputObjectsDelegate{

    var scanningView = SGScanningQRCodeView()
    var first_push: Bool = true
    let fortitle = UILabel()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.view.backgroundColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
//        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        
        scanningView = SGScanningQRCodeView(frame: (self.navigationController?.view.frame)!, outsideViewLayer: self.view.layer)
        
        fortitle.frame = CGRectMake(0, 0, 100, 44)
        fortitle.text = "扫一扫"
        fortitle.textColor = UIColor.whiteColor()
        fortitle.textAlignment = NSTextAlignment.Center
        self.navigationItem.titleView = fortitle
        self.view.addSubview(scanningView)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "相册", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(ZFBCodeScanningPage.readImageFromAlbum))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.whiteColor()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        scanningView.removeTimer()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupScanningQRCode()
    }

    //MARK -- 从相册中读取照片
    func readImageFromAlbum() {
        let imagePicker = UIImagePickerController() // 创建对象
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary //（选择类型）表示仅仅从相册中选取照片
        imagePicker.delegate = self
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    //MARK -- UIimagePickerControllerDelegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {

        //1.初始化一个监测器
        let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy : CIDetectorAccuracyHigh])
        picker.dismissViewControllerAnimated(false) { 
            //取得识别结果
            let features: NSArray = detector!.featuresInImage(CIImage(image: image)!)
            if features.count >= 1 {
                self.scanQRCodeFromPhotosInTheAlbum(image)
            }else{
                let alertController = UIAlertController(title: "提示", message: "该图片没有包含一个二维码！", preferredStyle: UIAlertControllerStyle.Alert)
                let alertSure = UIAlertAction(title: "确定", style: UIAlertActionStyle.Default, handler: nil)
                alertController.addAction(alertSure)
                self.presentViewController(alertController, animated: false, completion: nil)
            }
        }
        
    }
    
    //从相册中识别二维码，并进行输出语句
    func scanQRCodeFromPhotosInTheAlbum(image: UIImage) {
        // CIDetector(CIDetector可用于人脸识别)进行图片解析，从而使我们可以便捷的从相册中获取到二维码
        // 声明一个CIDetector，并设定识别类型 CIDetectorTypeQRCode
        let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy : CIDetectorAccuracyHigh])
        
        //取得识别结果
        let features: NSArray = detector!.featuresInImage(CIImage(image: image)!)
        
        if features.count == 1 {
            let feature = features[0] as? CIQRCodeFeature
            let scannedResult: NSString = feature!.messageString!
            if self.first_push == true {
                self.first_push = false
                let jumpVC = forCodeScan()
                jumpVC.forjump_URL = scannedResult as String
                self.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(jumpVC, animated: false)
                self.hidesBottomBarWhenPushed = false
            }
        }else {
            for index in 0...features.count {
                let feature = features[index] as? CIQRCodeFeature
                let scannedResult: NSString = feature!.messageString!
                if self.first_push == true {
                    self.first_push = false
                    let jumpVC = forCodeScan()
                    jumpVC.forjump_URL = scannedResult as String
                    self.hidesBottomBarWhenPushed = true
                    self.navigationController?.pushViewController(jumpVC, animated: false)
                    self.hidesBottomBarWhenPushed = false
                }
            }
        }
        
    }
    
    
    // MARK: - 1. 懒加载: 会话,输入设备,输出设备,预览图层
    //会话
    private lazy var session: AVCaptureSession = AVCaptureSession()
    
    //拿到输入设备
    private lazy var deviceInput: AVCaptureDeviceInput? = {
        
        //获取摄像头
        let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        
        do {
            //创建输入对象
            let input = try AVCaptureDeviceInput(device: device)
            return input
        } catch {
            //打印错误信息
            return nil
        }
    }()
    
    //拿到输出设备
    private lazy var output: AVCaptureMetadataOutput = AVCaptureMetadataOutput()
    
    //创建预览图层 传递session是为了告诉涂层来显示什么内容
    private lazy var previewLayer: AVCaptureVideoPreviewLayer = {
        
        let layer = AVCaptureVideoPreviewLayer(session: self.session)
        layer.videoGravity = AVLayerVideoGravityResizeAspectFill
        layer.frame = UIScreen.mainScreen().bounds
        return layer
    }()
    
    //MARK --二维码扫描
    func setupScanningQRCode() {
        
        //先判断是否能将设备添加到回话中
        if !session.canAddInput(deviceInput) {
            return
        }
        
        //判断是否能够将输出添加到回话中
        if !session .canAddOutput(output) {
            return
        }
        
        //将输入和输出添加到回话中
        session.addInput(deviceInput)
        session.addOutput(output)
        
        //设置输入能够解析的数据类型
        //设置能解析的数据类型,一定要在输出对象添加到会员之后设置
        output.metadataObjectTypes = output.availableMetadataObjectTypes
        
        //设置扫描范围（每一个取值0～1，以屏幕右上角为坐标原地）
        // 注：微信二维码的扫描范围是整个屏幕，这里并没有做处理（可不用设置）
        output.rectOfInterest = CGRectMake(0.05, 0.2, 0.7, 0.6);
        
        //设置代理 在主线程中刷新
        output.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        
        //添加预览图层
        view.layer.insertSublayer(previewLayer, atIndex: 0)
        //告诉session开始扫描
        session.startRunning()
        
        
    }
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        // 会频繁的扫描，调用代理方法
        // 0、扫描成功之后的提示音
        self.playSoundEffect("sound.caf")
        
        // 1、如果扫描完成，停止会话
        self.session.stopRunning()
        
        // 2、删除预览图层
        self.previewLayer.removeFromSuperlayer()
        
        
        
        // 3、设置界面显示扫描结果
        if metadataObjects.count > 0 {
            let obj = metadataObjects.last
            
            
            if obj!.stringValue.hasPrefix("http") {
                let jumpVC = forCodeScan()
                jumpVC.forjump_URL = obj!.stringValue
                self.navigationController?.pushViewController(jumpVC, animated: true)
            }else{ // 扫描结果为条形码
                let jumpVC = forCodeScan()
                jumpVC.forjump_bar_code = obj!.stringValue
                self.navigationController?.pushViewController(jumpVC, animated: true)
            }
        }
        
        
    }
    
    // 移除定时器
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        self.scanningView.removeTimer()
        self.scanningView.removeFromSuperview()
    }
    
    
    
    
    //MARK -- 扫描提示声
    /**
     *  播放完成回调函数
     *
     *  @param soundID    系统声音ID
     *  @param clientData 回调时传递的数据 d d
     */
    //    func soundCompleteCallback(soundID: SystemSoundID ,clientData: void){
    //        NSLog("播放完成...")
    //    }
    
    func playSoundEffect(name: NSString) {
        //获取声音地址
        let audioFile = NSBundle.mainBundle().pathForResource(name as String, ofType: nil)
        let fileUrl = NSURL(fileURLWithPath: audioFile!)
        // 1、获得系统声音ID
        var soundID: SystemSoundID = 0
        /**
         * inFileUrl:音频文件url
         * outSystemSoundID:声音id（此函数会将音效文件加入到系统音频服务中并返回一个长整ID）
         */
        AudioServicesCreateSystemSoundID(fileUrl, &soundID)
        
        // 如果需要在播放完之后执行某些操作，可以调用如下方法注册一个播放完成回调函数
        //        AudioServicesAddSystemSoundCompletion(soundID, nil, nil, soundCompleteCallback , nil)
        
        // 2、播放音频
        AudioServicesPlaySystemSound(soundID) // 播放音效
        /**
         //提醒（同上面唯一的一个区别）
         AudioServicesPlayAlertSound(soundID)
         //建立的SystemSoundID对象
         var soundID = SystemSoundID(kSystemSoundID_Vibrate)
         //振动
         AudioServicesPlaySystemSound(soundID)
         **/
        
    }
    

}
