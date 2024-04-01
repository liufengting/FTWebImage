//
//  ViewController.swift
//  Demo
//
//  Created by LiuFengting on 2024/4/1.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let cellIdentifier = "DemoCellIdentifier"
    
    let avatars = [ "http://wx4.sinaimg.cn/mw600/007wHJ1wly1gs6ocli7hlj318g0toary.jpg",
                    "http://wx1.sinaimg.cn/orj360/006KDv0Jly1gs1hys0m1zj33402c0qv5.jpg",
                    "http://wx1.sinaimg.cn/orj360/006KDv0Jly1gs1hytnobhj33402c0npd.jpg",
                    "http://wx1.sinaimg.cn/orj360/006KDv0Jly1gs1hyxep3aj31hc0u044q.jpg",
                    "http://wx1.sinaimg.cn/mw600/007wHJ1wly1gs1hnskhshj30go0fm41t.jpg",
                    "http://wx1.sinaimg.cn/mw600/007wHJ1wly1gs1h6z1k8rj30jg0pygo8.jpg",
                    "http://wx1.sinaimg.cn/mw600/007wHJ1wly1gs1gs24581j30u00wvwg7.jpg"]

    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    //MARK: - UITableViewDelegate, UITableViewDataSource -
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return avatars.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DemoCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! DemoCell
        cell.setupWith(imageURL: avatars[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

