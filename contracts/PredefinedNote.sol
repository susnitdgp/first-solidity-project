//SPDX-License-Identifier:UNLICENSED
pragma solidity ^0.8.7;

contract PredefinedNote{
    
    string fileId;
    string subject;
    
    struct annexure{
        string name;
        string mime;
        string ipfsUrl;
    }
    
    annexure[] uploadedAnnexure;
    
    struct Employee{
        address walletNumber;
        string empNum;
        string empName;
        string designation;
        string plantName;
    }
    
    string notesheetUrl;
    
    Employee sender;
    
    address recipient;
    
    function setTitle(string memory _title) external returns(bool){
        subject=_title;
        return true;
    }
    
    function getTitle() external view returns(string memory){
        return subject;
    }
}

contract WorkFlow{
    
   // mapping(address => PredefinedNote) instantiatedNotes;
   
    PredefinedNote[] instantiatedNotes;
    uint totalEntries = 0;
    
    function createPredefinedNote(string memory _title) public returns (bool){
        PredefinedNote _temp=new PredefinedNote();
        _temp.setTitle(_title);
        
        instantiatedNotes.push(_temp);
        ++totalEntries;
        
        return true;
        
    }
    
    function returnProcessCount() public view returns(uint){
        return totalEntries;
    }
    
    function getTitleIndex(uint _index) public view returns(string memory){
        if(_index <= instantiatedNotes.length-1){
            PredefinedNote p=instantiatedNotes[_index];
            return p.getTitle();
        }else{
            return "Array Out of Bound";
        }
        
    }
    
}