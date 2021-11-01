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

struct PredefinedNoteTracker{
    bytes32 trackerId;
    address currentOwner;
}

contract PredefinedWorkFlow{
    
    mapping(bytes32 => PredefinedNote) instantiatedNotes;
    PredefinedNoteTracker[] instantiatedNotesTrackers;
    
    mapping(address=>Employee) validEmployees;
    
    
    //Functionality Start
    event Response(bytes32,address);
    function createPredefinedNote(string memory _fileId,string memory _subject) public{
        
        bytes32 _noteid=getNoteId();
        uint _currentTime=block.timestamp;
        
        Notesheet memory _notesheet=Notesheet("abc",123456);
        
        PredefinedNote memory _temp=PredefinedNote(_fileId,_subject,_currentTime,_notesheet);
        instantiatedNotes[_noteid]=_temp;
        
        PredefinedNoteTracker memory _tracker=PredefinedNoteTracker(_noteid,0xd8b934580fcE35a11B58C6D73aDeE468a2833fa8);
        instantiatedNotesTrackers.push(_tracker);
      
        
        emit Response(_noteid,0xd8b934580fcE35a11B58C6D73aDeE468a2833fa8);
        
    }
    
    function getSubject() public view returns(string memory){
        
        string memory _subject;
        for(uint i=0;i<instantiatedNotesTrackers.length;i++){
            PredefinedNoteTracker memory _temp=instantiatedNotesTrackers[i];
            _subject=instantiatedNotes[_temp.trackerId].subject;
        }
        
        return _subject;
    }
    
    
    function getListofFiles() public view returns(bytes32,address){
        
        return (instantiatedNotesTrackers[0].trackerId,instantiatedNotesTrackers[0].currentOwner);
    }
    
    function getNoteId() internal view returns(bytes32)
    {
        // increase nonce
        uint randNonce=instantiatedNotesTrackers.length+1; 
        return (keccak256(abi.encodePacked(block.timestamp,msg.sender,randNonce))) ;
    }
    
}
