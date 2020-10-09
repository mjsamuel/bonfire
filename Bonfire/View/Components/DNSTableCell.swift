//
//  TableViewCellWithData.swift
//  Bonfire
//
//  Created by Kurt Invernon on 9/10/20.
//  Copyright © 2020 ipse. All rights reserved.
//

import UIKit

class DNSTableCell: UITableViewCell {
    
    public var dnsRecord:DNS?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
