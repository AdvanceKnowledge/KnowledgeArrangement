//
//  VideoPlaybackViewController.swift
//  KnowledgeArrangement
//
//  Created by 王延磊 on 2022/7/29.
//  Copyright © 2022 ProgrammerHome. All rights reserved.
//

import UIKit
import WMPlayer
import RealmSwift
//NSIndexPath *currentIndexPath;
//BOOL isSmallScreen;
class VideoPlaybackViewController: ParentsVC {
    let videowListTab = OABaseTab()
    var videoModels = [VideoModel]()
    var currentIndexPath = IndexPath()
    var isSmallScreen = false
    var videoPlayer: WMPlayer?
    var currentCell: MyVideoCell!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        videowListTab.delegate = self
        videowListTab.dataSource = self
        videowListTab.register(UINib.init(nibName: "MyVideoCell", bundle: nil), forCellReuseIdentifier: "MyVideoCell")
        self.view.addSubview(videowListTab)
        videowListTab.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
//        let listmodel = RealmManager.share.findObjects(withType: VideoListModel.self).first ?? VideoListModel()
//        
//        videoModels = listmodel.listModel
//        if videoModels.count == 0 {
//            getVideoInforRequest()
//        }
        getVideoInforRequest()
//        注册屏幕旋转通知
        NotificationCenter.default.addObserver(self, selector: #selector(onDeviceOrientationChange), name: UIDevice.orientationDidChangeNotification, object: nil)
        
    }
    
    
    
    
    @objc func onDeviceOrientationChange() {
        if (videoPlayer == nil || videoPlayer?.superview == nil){
            return
        }
        
        let orientation = UIDevice.current.orientation
        
        switch orientation {
        case .unknown:
            break
        case .portrait:
            
//            if (videoPlayer.isFullscreen) {
           //                if (isSmallScreen) {
           //                    //放widow上,小屏显示
           //                    [self toSmallScreen];
           //                }else{
           //                    [self toCell];
           //                }
           //            }
            
            if videoPlayer!.isFullscreen {
                if isSmallScreen {
                    
                }
            }
            
            print("垂直方向 Home 键在底部")
            break
        case .portraitUpsideDown:
            print("垂直方向 Home 键在顶部")
            break
        case .landscapeLeft:
            print("垂直方向 Home 键在左边")
            break
        case .landscapeRight:
            print("垂直方向 Home 键在右边")
            break
        case .faceUp:
            print("水平方向  正面朝上")
            break
        case .faceDown:
            print("水平方向  背面朝上")
            break
        }
    }
    
    
    @objc func startPlayVideo(_ btn: UIButton) {
        currentIndexPath = IndexPath(row: btn.tag, section: 0)
        self.currentCell = btn.superview?.superview as? MyVideoCell ?? MyVideoCell()
        let model = self.videoModels[btn.tag]
        if isSmallScreen {
            videoPlayer?.resetWMPlayer()
            isSmallScreen = false
        } else {
            videoPlayer?.resetWMPlayer()
        }
        self.createVideoPlayer(model: model)
        self.videowListTab.reloadData()
        
    }
    
    func createVideoPlayer(model: VideoModel) {
        
        let wmplayerModel = WMPlayerModel()
        
        wmplayerModel.title = model.title
        wmplayerModel.videoURL = URL.init(string: model.mp4_url)!
//        wmplayerModel.presentationSize = self.currentCell.backgroundIV.bounds.size
        
        if videoPlayer == nil {
            videoPlayer = WMPlayer.init(model: wmplayerModel)
        }else {
            videoPlayer?.playerModel = wmplayerModel
        }
        
        
    }
    

    
    /// 小窗播放
    func toSmallScreen() {
        videoPlayer!.removeFromSuperview()
        UIView.animate(withDuration: 0.7) {
            self.videoPlayer?.transform = CGAffineTransform.identity
            self.videoPlayer?.frame = CGRect(x: UIScreen.main.bounds.size.width/2.0,
                                        y: UIScreen.main.bounds.size.height - (UIScreen.main.bounds.size.height/2.0)*0.75,
                                        width: UIScreen.main.bounds.size.width/2.0,
                                        height: (UIScreen.main.bounds.size.height/2.0)*0.75)
            
            UIApplication.shared.keyWindow?.addSubview(self.videoPlayer!)
            
        }
    }
    
    
    //网络请求
    func getVideoInforRequest() {
        NetTools.request("https://c.m.163.com/nc/video/home/0-10.html", method: .get, paramas: nil) { (isSuccess, posts, error) in
            if (!isSuccess){
                //请求失败
                return
            }
            let arr = posts?["videoList"] as! NSArray
            
            self.videoModels = JsonUtil.jsonArraryToModels(arr, modelType: VideoModel.self) as? [VideoModel] ?? [VideoModel]()
//            let listModel = VideoListModel.deserialize(from: posts, designatedPath: nil) ?? VideoListModel()
//            self.videoModels = listModel.listModel
//            RealmManager.share.updateObject(listModel)
            self.videowListTab.reloadData()
        }
    }

}

extension VideoPlaybackViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoModels.count
//
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyVideoCell") as? MyVideoCell ?? MyVideoCell()
        cell.model = videoModels[indexPath.row]
//        cell.playBtn.tag = indexPath.row
//        cell.playBtn.addTarget(self, action: #selector(startPlayVideo(_:)), for: .touchUpInside)
//        
//        if videoPlayer != nil && videoPlayer?.superview != nil {
//            if indexPath.row == currentIndexPath.row {
//                cell.playBtn.superview?.bringSubviewToFront(cell.backgroundIV)
//            } else {
//                cell.playBtn.superview?.sendSubviewToBack(cell.backgroundIV)
//            }
//        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 274
    }
}
