//SPDX-License-Identifier:UNLICENSED
pragma solidity ^0.8.7;

struct Annexure{
   
    string ipfsUrl;
    uint256 uploadDate;
}
struct Notesheet{
    
    string ipfsUrl;
    uint256 uploadDate;
}
struct Employee{
    address walletNumber;
    string empNum;
    string empName;
    string designation;
    string plantName;
}

struct UserAction{
    address fromAddress;
    address toAddress;
    string action;
    uint256 actionTime;
}

struct PredefinedNote{
    
    string fileId;
    string subject;
    uint256 creationTime;
    
    //Annexure[] annexures;
  
    Notesheet notesheet;
    
    //address initiator;
    //address[] filePaths;
    //address currentOwner;
    
    //UserAction[] userActions;
    
    //string currentStatus;
    
}

struct NoteTracker{
    uint256 trackerId;
    address currentOwner;
}

contract WorkFlow{
    
    mapping(uint256 => PredefinedNote) instantiatedNotes;
   
    NoteTracker[] trackers;
    
    mapping(address=>Employee) orgEmployees;
    
    
    //Functionality Start
    function createPredefinedNote(string memory _fileId,string memory _subject) public returns (uint256){
        
        uint256 time=block.timestamp;
        
        Notesheet memory _notesheet=Notesheet("abc",time);
        
        PredefinedNote memory _temp=PredefinedNote(_fileId,_subject,time,_notesheet);
        instantiatedNotes[block.timestamp]=_temp;
        
        NoteTracker memory _tracker=NoteTracker(time,0xd8b934580fcE35a11B58C6D73aDeE468a2833fa8);
        trackers.push(_tracker);
      
        
        return time;
        
    }
    
    function getTitle(uint256 _id) public view returns(string memory){
        PredefinedNote memory _temp=instantiatedNotes[_id];
        return _temp.subject;
    }
    
}