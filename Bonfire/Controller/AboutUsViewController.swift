//
//  AboutUsViewController.swift
//  Bonfire
//
//  Created by Matthew Samuel on 5/10/20.
//  Copyright © 2020 ipse. All rights reserved.
//

import UIKit
import AVKit
import MobileCoreServices

class AboutUsViewController: UITableViewController {
    
    private var viewModel: AboutUsViewModel = AboutUsViewModel()
    
    var avPlayerViewController: AVPlayerViewController!
    var image: UIImage?
    var lastChosenMediaType: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.team.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "teamIdentifier", for: indexPath)

        let teamMember: TeamMember = viewModel.team[indexPath.row]

        let nameLabel = cell.viewWithTag(1000) as! UILabel
        nameLabel.text = teamMember.name

        let idLabel = cell.viewWithTag(1001) as! UILabel
        idLabel.text = teamMember.id
        
        let imageView = cell.viewWithTag(1002) as! UIImageView
        if let memberImage = teamMember.image {
            imageView.image = memberImage
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pickMediaFromSource(UIImagePickerControllerSourceType.camera)
        
        // Updating view model and refreshing table data
        if let capturedImage = self.image {
            viewModel.team[indexPath.row].image = capturedImage
            tableView.reloadData()
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // This method gets called by the action methods to select
    // what type of media the user wants.
    func pickMediaFromSource(_ sourceType:UIImagePickerControllerSourceType) {
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            let picker = UIImagePickerController()
            picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: sourceType)!
            picker.delegate = self
            picker.allowsEditing = true
            picker.sourceType = sourceType
            present(picker, animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(title:"Error accessing media", message: "Unsupported media source.", preferredStyle: UIAlertControllerStyle.alert)

            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
            
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }
    }
}

extension AboutUsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        lastChosenMediaType = info[UIImagePickerControllerMediaType] as? String
        
        if let mediaType = lastChosenMediaType {
            if mediaType == (kUTTypeImage as NSString) as String {
                image = info[UIImagePickerControllerEditedImage] as? UIImage
            }
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion:nil)
    }
}
