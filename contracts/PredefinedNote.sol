//SPDX-License-Identifier:UNLICENSED
pragma solidity ^0.8.7;

struct annexure{
        string name;
        string mime;
        string ipfsUrl;
    }
struct Employee{
        address walletNumber;
        //string empNum;
        string empName;
        //string designation;
       // string plantName;
    }

struct  PredefinedNote{
    
    string fileId;
    string subject;
    
  
    //annexure[] uploadedAnnexure;
  
    //string notesheetUrl;
    
    Employee sender;
    
    //address recipient;
    
    
}

contract WorkFlow{
    
   // mapping(address => PredefinedNote) instantiatedNotes;
   
    PredefinedNote[] instantiatedNotes;
    uint totalEntries = 0;
    
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
        
    }
    
}