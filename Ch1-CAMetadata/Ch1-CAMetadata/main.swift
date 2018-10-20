//
//  main.swift
//  Ch1-CAMetadata
//
//  Created by Mikhail Bhuta on 10/19/18.
//  Copyright © 2018 MBhuta. All rights reserved.
// 

import Foundation
import AudioToolbox

func main() {
    
    let argc = CommandLine.argc
    let argv = CommandLine.arguments
    
    guard argc > 1 else {
        print("Usage: CAMetaData /full/path/to/audiofile\n")
        return
    }
    
    if let audioFilePath = String(utf8String: argv[1])?.replacingOccurrences(of: "~", with: FileManager.default.homeDirectoryForCurrentUser.path) {
        
        let audioURL = URL(fileURLWithPath: audioFilePath)
        var audioFile: AudioFileID? = nil
        var theErr = noErr
        
        theErr = AudioFileOpenURL(audioURL as CFURL, .readPermission, 0, &audioFile)
        
        assert(theErr == noErr)
        
        var dictionarySize: UInt32 = 0
        var isWritable: UInt32 = 0
        theErr = AudioFileGetPropertyInfo(audioFile!, kAudioFilePropertyInfoDictionary, &dictionarySize, &isWritable)
        
        assert(theErr == noErr)
        
        var dictionary: UnsafePointer<CFDictionary>? = nil
        theErr = AudioFileGetProperty(audioFile!, kAudioFilePropertyInfoDictionary, &dictionarySize, &dictionary)
        
        assert(theErr == noErr)
        NSLog("dictionary: %@", dictionary!)
        
        theErr = AudioFileClose(audioFile!)
        assert(theErr == noErr)
    }
    else {
        print("File not found")
    }
    
}

main()



