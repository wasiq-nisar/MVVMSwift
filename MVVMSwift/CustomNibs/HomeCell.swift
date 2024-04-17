//
//  HomeCell.swift
//  MVVMSwift
//
//  Created by Muhammad Wasiq  on 15/04/2024.
//

import UIKit
import LinkPresentation
import MobileCoreServices

class HomeCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var cardName: UILabel!
    @IBOutlet weak var cardType: UILabel!
    @IBOutlet weak var cardDescription: UILabel!
    
    // MARK: - Variables
    static let identifier = "HomeCell"
    
    // MARK: - ViewLoad Functions
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - UserDefined Functions
    func updateUI(data: (name: String, type: String, desc: String, imageURL: String?)) {
        cardName.text = data.name
        cardType.text = data.type
        cardDescription.text = data.desc
        
        guard let urlString = data.imageURL, let imageUrl = URL(string: urlString) else {
            return
        }
        
        let metadataProvider = LPMetadataProvider()
        metadataProvider.startFetchingMetadata(for: imageUrl) { metaData, error in
            if error != nil {
                // The fetch failed; handle the error.
                return
            }
            let IMAGE_TYPE = kUTTypeImage as String
            metaData?.imageProvider?.loadFileRepresentation(forTypeIdentifier: IMAGE_TYPE, completionHandler: { url, imageProviderError in
                if imageProviderError != nil {
                    // The fetch failed; handle the error.
                    return
                }
                print("url?.path: ", (url?.path)!)
                let myImage = UIImage(contentsOfFile: (url?.path)!)
                DispatchQueue.main.async {
                    self.cardImage.image = myImage
                }
            })
        }
    }
}
