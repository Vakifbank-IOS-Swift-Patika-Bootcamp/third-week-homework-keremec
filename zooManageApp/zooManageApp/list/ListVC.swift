//
//  ListVC.swift
//  zooManageApp
//
//  Created by Kerem Safa Dirican on 18.11.2022.
//

import UIKit
import AVFoundation

class ListVC: UIViewController {

    var player: AVAudioPlayer?
    
    weak var delegateListVC:HomeVC?
    
    var list = [listMember]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        for i in delegateListVC!.zoo.animalSitters{
            list.append(listMember(title: "--> \(i.name)", detail: String(i.id)))
            for j in i.animals{
                list.append(listMember(title: j.name, detail: j.type.rawValue))
            }
        }
    }
    


}


extension ListVC: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath)
        
        let obj = list[indexPath.row]
        
        cell.textLabel?.text = obj.title
        cell.detailTextLabel?.text = obj.detail
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selector = list[indexPath.row].detail.prefix(1)
        switch selector {
        case "😺":
            playSound(name: "cat")
        case "🐶":
            playSound(name: "dog")
        default:
            print("Not an Animal")
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}

struct listMember {
    let title:String
    let detail:String
}

extension ListVC{
    func playSound(name:String) {
        print(name)
        guard let path = Bundle.main.path(forResource: name, ofType:"wav") else {
            return }
        let url = URL(fileURLWithPath: path)

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
