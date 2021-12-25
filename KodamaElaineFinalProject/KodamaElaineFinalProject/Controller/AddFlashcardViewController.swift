//
//  AddFlashcardViewController.swift
//  KodamaElaineFinalProject
//
//  Created by Elaine Kodama on 5/2/21.
//

import UIKit
import PencilKit
import  Firebase
class AddFlashcardViewController: UIViewController, PKCanvasViewDelegate, PKToolPickerObserver {
    
    @IBOutlet weak var frontCanvasView: PKCanvasView!
    @IBOutlet weak var backCanvasView: PKCanvasView!
    @IBOutlet weak var saveButton: UIButton!
    var folderTitle: String!
    var setTitle: String!
    
    let canvasWidth: CGFloat = 350
    let canvasHeight: CGFloat = 233.33
    let toolPicker = PKToolPicker()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clearDrawings()
        
        frontCanvasView.delegate = self
        frontCanvasView.alwaysBounceVertical = true
        frontCanvasView.alwaysBounceHorizontal = true
        toolPicker.setVisible(true, forFirstResponder: frontCanvasView)
        toolPicker.addObserver(frontCanvasView)
        frontCanvasView.becomeFirstResponder()
        
        backCanvasView.delegate = self
        backCanvasView.alwaysBounceVertical = true
        backCanvasView.alwaysBounceHorizontal = true
        toolPicker.setVisible(true, forFirstResponder: backCanvasView)
        toolPicker.addObserver(backCanvasView)
        backCanvasView.becomeFirstResponder()
    }
//
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

//        let canvasScale = frontCanvasView.bounds.width
//        frontCanvasView.minimumZoomScale = canvasScale
//        frontCanvasView.maximumZoomScale = canvasScale
//        frontCanvasView.zoomScale = canvasScale
//
//        if frontCanvasView.isFirstResponder {
//            viewDidLayoutHelper(canvasView: frontCanvasView)
//            updateDrawingSize(canvasView: frontCanvasView)
//        }
//        else{
//            viewDidLayoutHelper(canvasView: backCanvasView)
//            updateDrawingSize(canvasView: backCanvasView)
//        }
      }

//    func viewDidLayoutHelper(canvasView: PKCanvasView){
//        let canvasScale = canvasView.bounds.width
//        canvasView.minimumZoomScale = canvasScale
//        canvasView.maximumZoomScale = canvasScale
//        canvasView.zoomScale = canvasScale
//
//        //updateDrawingSize()
//        canvasView.contentOffset = CGPoint(x: 0, y: -canvasView.adjustedContentInset.top)
//    }

    @IBAction func userDidTappedSave(_ sender: UIButton) {
        let front = saveDrawing(canvasView: frontCanvasView)
        let back = saveDrawing(canvasView: backCanvasView)
        
        FirestoreModel.shared.addFlashcards(folderTitle: folderTitle, setTitle: setTitle, frontDrawing: front, backDrawing: back, favorite: false)
        clearDrawings()
    }
    
    func clearDrawings(){
        frontCanvasView.drawing = PKDrawing()
        backCanvasView.drawing = PKDrawing()
    }

    func saveDrawing(canvasView: PKCanvasView) -> Data{
        UIGraphicsBeginImageContextWithOptions(canvasView.bounds.size, false, UIScreen.main.scale)
        canvasView.drawHierarchy(in: canvasView.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return FirestoreModel.shared.getDataFromImage(image: image) as! Data
        //return Any from screenshot image
    }


//    func updateDrawingSize(canvasView: PKCanvasView){
//        let drawing = canvasView.drawing
//        let contentHeight: CGFloat
//
//        if drawing.bounds.isNull{
//            contentHeight = max(canvasView.bounds.height, (drawing.bounds.maxY + self.canvasHeight) * canvasView.zoomScale)
//        }
//        else{
//            contentHeight = canvasView.bounds.height
//        }
//        canvasView.contentSize = CGSize(width: canvasWidth * canvasView.zoomScale, height: contentHeight)
//    }
//
//    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
//        updateDrawingSize(canvasView: canvasView)
//    }

//extension UIImage {
//    var jpeg: Data? { jpegData(compressionQuality: 1) }  // QUALITY min = 0 / max = 1
//    var png: Data? { pngData() }

}
