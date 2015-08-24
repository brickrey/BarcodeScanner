//
//  Utility.swift
//  Image Scanner
//
//  Created by Brick Reyes Zambrano on 23/8/15.
//  Copyright © 2015 Brick Reyes Zambrano. All rights reserved.
//

import Foundation
import AVFoundation

class Utility {
    
    /// Barcode type to scan.
    static let barCodeTypes = [AVMetadataObjectTypeUPCECode,
        AVMetadataObjectTypeCode39Code,
        AVMetadataObjectTypeCode39Mod43Code,
        AVMetadataObjectTypeEAN13Code,
        AVMetadataObjectTypeEAN8Code,
        AVMetadataObjectTypeCode93Code,
        AVMetadataObjectTypeCode128Code,
        AVMetadataObjectTypePDF417Code,
        AVMetadataObjectTypeQRCode,
        AVMetadataObjectTypeAztecCode]
}