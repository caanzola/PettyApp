//
//  UrgenciaViewController.swift
//  Petty
//
//  Created by CAMILO ANDRES ANZOLA GONZALEZ on 2/22/19.
//  Copyright © 2019 CAMILO ANDRES ANZOLA GONZALEZ. All rights reserved.
//

import UIKit
import AVFoundation
import FirebaseStorage

class UrgenciaViewController: UIViewController, UITextViewDelegate, AVAudioRecorderDelegate , AVAudioPlayerDelegate , UINavigationControllerDelegate , UIImagePickerControllerDelegate  {
    
    
    @IBOutlet weak var myTextView: UITextView!
    var textInput = ""
    let network: NetworkManager = NetworkManager.sharedInstance
    //@IBOutlet weak var myTextView: UITextView!
    
    
    @IBOutlet weak var imageButton: UIButton!
    
    @IBOutlet weak var recordButton: UIButton!
    
    @IBOutlet weak var playButton: UIButton!
    
    var soundRecorder : AVAudioRecorder!
    
    var soundPlayer : AVAudioPlayer!
    
    
    var fileName : String =  "audioFile.m4a"
    
    
    var recordingSession : AVAudioSession!
    
    var audioRecorder : AVAudioRecorder!
    
    
    var imageReference: StorageReference{
        return Storage.storage().reference() .child("images")
    }
    
    
    var imageFfileName: String = "image.jpg"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkManager.isUnreachable { _ in
            showOfflinePage()
        }
        
        func showOfflinePage() {
            
            let alert = UIAlertController(title: "No hay conexión a internet", message: "Sin conexión a internet no puedes solicitar una urgencia veterinaria, sin embargo puedes llamar a las veterinarias cercanas y solicitar ayuda.", preferredStyle: .alert)
            let subButton = UIAlertAction(title: "Ok", style: .default, handler: solicitarSinInternet)
            
            alert.addAction(subButton)
            self.present(alert, animated: true, completion: nil)
        }
        
        // record audio
        
        
        // finish record audio
        //
        
        self.myTextView.layer.cornerRadius = 8
        self.myTextView.layer.borderColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1).cgColor
        self.myTextView.layer.borderWidth = 1.0
        
        myTextView.delegate = self
        /*
         self.myTextField.layer.cornerRadius = 8
         self.myTextField.layer.borderColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1).cgColor
         self.myTextField.layer.borderWidth = 1.0
         myTextField.delegate = self*/
        // Do any additional setup after loading the view.
        
        setupRecorder()
        playButton.isEnabled = false
        
        
    }
    
    func solicitarSinInternet(alert: UIAlertAction)
    {
        performSegue(withIdentifier: "noConex", sender: self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
    
    
    @IBAction func send(_ sender: UIBarButtonItem)
    {
        
        
        
        performSegue(withIdentifier: "uno", sender: self)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        /*
        guard let image = imageButton.currentImage else {return}
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {return}
        let uploadImageRef = imageReference.child(imageFfileName)
        let uploadTask = uploadImageRef.putData(imageData, metadata: nil) { (metadata, error) in
            print("Upload task finished")
            print(metadata ?? "No metadata")
            print(error ?? "No error")
        }
        uploadTask.observe(.progress) { (snapshot) in
            print(snapshot.progress ?? "No more progress")
        }
        uploadTask.resume()
        */
        
        if segue.identifier == "noConex"
        {
            var vc = segue.destination as! UrgenciaSinConexionViewController
        }
        else
        {
            print("hshshshshshshshshshshs")
            var vc = segue.destination as! MapaUrgenciaViewController
            vc.descript = myTextView.text
            print(imageButton.currentImage)
            vc.imagen = imageButton.currentImage
            
            //vc.imageSelected.setImage(imageButton.currentImage, for: .normal)
            
            print(" ")
            print(" ")
            print("Cambioo ")
            print(myTextView.text)
            print(" ")
            print(" ")
        }
        
    }
    
    @IBAction func isEditing(_ sender: UITextField)
    {
        textInput = sender.text!
        
        print(textInput)
    }
    
    
    
    
    
    // todo esto es para audio recorder //
    
    
    
    func getDocumentsDirector() -> URL {
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        return paths[0]
        
    }
    
    
    
    func setupRecorder() {
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSession.Category.playAndRecord, mode: .default)
        } catch let error as NSError {
            print(error.description)
        }
        
        let recordSettings = [AVSampleRateKey : NSNumber(value: Float(44100.0)),
                              AVFormatIDKey : NSNumber(value: Int32(kAudioFormatMPEG4AAC)),
                              AVNumberOfChannelsKey : NSNumber(value: 1),
                              AVEncoderAudioQualityKey : NSNumber(value: Int32(AVAudioQuality.max.rawValue))]
        
        do{
            try soundRecorder = AVAudioRecorder(url: getDocumentsDirector().appendingPathComponent(fileName), settings: recordSettings)
            soundRecorder.delegate = self
            soundRecorder.prepareToRecord()
        }
        catch let error as NSError {
            error.description
        }
        
        
        
        /*
        let audioFilename = getDocumentsDirector().appendingPathComponent(fileName)
        
        let audioSession = AVAudioSession.sharedInstance()
        
       /* let recordSetting = [ AVFormatIDKey : kAudioFormatAppleLossless,
                              
                              AVEncoderAudioQualityKey : AVAudioQuality.max.rawValue,
                              
                              AVEncoderBitRateKey : 320000,
                              
                              AVNumberOfChannelsKey : 2,
                              
                              AVSampleRateKey : 44100.2] as [String : Any]*/
        
        
        
        do {
            
            soundRecorder = try AVAudioRecorder(url: audioFilename, settings: recordSetting )
            
            soundRecorder.delegate = self
            
            soundRecorder.prepareToRecord()
            
        } catch {
            
            print(error)
            
        }
        */
    }
    
    
    
    func setupPlayer() {
        
        let audioFilename = getDocumentsDirector().appendingPathComponent(fileName)
        print(" ")
        print(" ")
        print(audioFilename)
        print(" ")
        print(" ")
        
        do {
            
            soundPlayer = try AVAudioPlayer(contentsOf: audioFilename)
            
            soundPlayer.delegate = self
            
            soundPlayer.prepareToPlay()
            
            soundPlayer.volume = 100.0
            
        } catch {
            
            print(error)
            
        }
        
    }
    
    
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        
        playButton.isEnabled = true
        
    }
    
    
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        
        recordButton.isEnabled = true
        
        playButton.setTitle("Play", for: .normal)
        
    }
    
    
    
    // aqui termina audio recorder //
    
    //
    
    
    @IBAction func selectImage(_ sender: UIButton)
    {
        /*
         
         let imageController = UIImagePickerController()
         
         imageController.delegate = self
         
         imageController.sourceType = UIImagePickerController.SourceType.photoLibrary
         
         self.present(imageController, animated: true , completion: nil)
         
         */
        
        
        
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.delegate = self
        
        
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        
        
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                
                imagePickerController.sourceType = .camera
                
                self.present(imagePickerController, animated: true, completion: nil)
                
            }else{
                
                print("Camera is not available")
                
            }
            
            
            
        }))
        
        
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in
            
            imagePickerController.sourceType = .photoLibrary
            
            self.present(imagePickerController, animated: true, completion: nil)
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        //imageView.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        
        
        
        imageButton.setImage(info[UIImagePickerController.InfoKey.originalImage] as? UIImage, for: .normal)
       
        
        
        
        
        //self.dismiss(animated: true, completion: nil)
        
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    
    
    // aqui termina lo del imagepicker
    
    
    
    // metodos action para el audiorecorder
    
    
    @IBAction func recordAction(_ sender: Any)
    {
        if recordButton.titleLabel?.text == "Record" {
            
            soundRecorder.record()
            
            recordButton.setTitle("Stop", for: .normal)
            
            playButton.isEnabled = false
            
        } else {
            
            soundRecorder.stop()
            
            recordButton.setTitle("Record", for: .normal)
            
            playButton.isEnabled = false
            
        }
    }
    
    
    @IBAction func playAction(_ sender: Any)
    {
        if playButton.titleLabel?.text == "Play" {
            
            playButton.setTitle("Stop", for: .normal)
            
            recordButton.isEnabled = false
            
            setupPlayer()
            
            soundPlayer.play()
            
        } else {
            
            soundPlayer.stop()
            
            playButton.setTitle("Play", for: .normal)
            
            recordButton.isEnabled = false
            
        }
    }
    
    
    
}
