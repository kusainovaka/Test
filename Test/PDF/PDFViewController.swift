//
//  PDFViewController.swift
//  Test
//
//  Created by Kamila on 4/22/20.
//  Copyright © 2020 Kamila Kusainova. All rights reserved.
//

import UIKit
import PDFKit

class PDFViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Add PDFView to view controller.
        let pdfView = PDFView(frame: self.view.bounds)
        self.view.addSubview(pdfView)

        // Fit content in PDFView.
        pdfView.autoScales = true

        // Load Sample.pdf file.
        let fileURL = Bundle.main.url(forResource: "usa_citizen", withExtension: "pdf")
        pdfView.document = PDFDocument(url: fileURL!)
    }

}
