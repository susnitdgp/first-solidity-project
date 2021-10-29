//SPDX-License-Identifier:UNLICENSED
pragma solidity ^0.8.7;

struct Annexure{
    string name;
    string mime;
    string ipfsUrl;
    uint uploadDate;
}
struct Notesheet{
    string name;
    string mime;
    string ipfsUrl;
    uint uploadDate;
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
    uint actionTime;
}

struct PredefinedNote{
    
    string fileId;
    string subject;
    uint creationTime;
    
    Annexure[] annexures;
  
    Notesheet notesheet;
    
    Employee initiator;
    Employee currentOwner;
    
    UserAction[] userActions;
    
    string currentStatus;
    
}

contract WorkFlow{
    
    mapping(string => PredefinedNote) instantiatedNotes;
   
    PredefinedNote[] instantiatedNotes;
    uint totalEntries = 0;
    
    /*
    function createPredefinedNote(string memory _title) public returns (bool){
        Employee memory _emp=Employee(msg.sender,"Susanta Goswami");
        PredefinedNote memory _temp=PredefinedNote("123",_title,_emp);
        //_temp.subject=_title;
        
        instantiatedNotes.push(_temp);
        ++totalEntries;
        
        return true;
        
    }
    
    function returnProcessCount() public view returns(uint){
        return totalEntries;
    }
    
    function getTitleIndex(uint _index) public view returns(string memory){
        if(_index <= instantiatedNotes.length-1){
            PredefinedNote memory p=instantiatedNotes[_index];
            return p.subject;
        }else{
            return "Array Out of Bound";
        }
        
    }
    
    
    function getWalletNumber(uint _index) public view returns(string memory){
        if(_index <= instantiatedNotes.length-1){
            PredefinedNote memory p=instantiatedNotes[_index];
            return p.sender.empName;
        }else{
            return "Array Out of Bound";
        }
        
    }*/
    
}