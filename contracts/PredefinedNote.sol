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
    bytes32 noteId;
    string fileId;
    string subject;
    uint256 creationTime;
    
    //Annexure[] annexures;
  
    Notesheet notesheet;
    
    address initiator;
    //address[] filePaths;
    address currentOwner;
    
    //UserAction[] userActions;
    
    string currentStatus;
    
}

struct PredefinedNoteTracker{
    bytes32 noteId;
    address currentOwner;
}

contract PredefinedWorkFlow{
    
    //Admin State variable
    address owner;
    
    //Functional state variable
    mapping(bytes32 => PredefinedNote) instantiatedNotes;
    PredefinedNoteTracker[] instantiatedNotesTrackers;
    
    Employee[] validEmployees;
    
    //constructor to set admin varaible
    constructor(){
        
        // Deployer of the contract become owner
        owner=msg.sender;
        
        //Few Sample Employees of the organization
        Employee memory sg=Employee(0x3C9600304FcEd7Fc41DF9f599E4bCd50dd90347d, "009697","Susanta Goswami","Sr Manager","CC-EOC"); // SGoswami Account Metamask Address
        validEmployees.push(sg); 
        Employee memory sm=Employee(0x6da0bED124A48e8a1431cdBe15ba36f379ca83d7, "009394","Sachin Muneswar","Sr Manager","CC-EOC"); // SMuneswar Account Metamask Address
        validEmployees.push(sm);
        
    }
    
    //custom error
    error NotOwner(address requester,string message);
    
    //Add New Employee to Workflow chain
    event AddEmployeesResponse(address,string);
    function setOrgEmployees(Employee memory _emp) public{
        if (msg.sender != owner) {
            
            revert NotOwner({requester: msg.sender, message: "Not a valid Owner of the contract"});
        }
        validEmployees.push(_emp);
        emit AddEmployeesResponse(msg.sender,"New Employee Added");
    }
    //Get List of Employee from Workflow chain
    function getOrgEmployees() public view returns(Employee[] memory){
        
        if (msg.sender != owner) {
            
            revert NotOwner({requester: msg.sender, message: "Not a valid Owner of the contract"});
        }
        return validEmployees;
        
    }
    //Create Predefined Notesheet
    //Modifiers can take inputs. This modifier checks that the
    //address passed is in allowed organizational employee list
    modifier validAddress(address _creator) {
        bool flag=false;
        for(uint i=0;i<validEmployees.length;i++){
            if(validEmployees[i].walletNumber == _creator){
                flag=true;
            }
        }
        require(flag == true, "Not a valid Org Address-No permission to create Note");
        _;
    }
    event CreateResponse(bytes32,address);
    function createPredefinedNote(string memory _fileId,string memory _subject, address _recipient) public validAddress(msg.sender) returns(bytes32){
        
        if(_recipient == address(0)){
            _recipient=msg.sender;
        }
        
        bytes32 _noteid=getNoteId();
        uint _currentTime=block.timestamp;
        
        Notesheet memory _notesheet=Notesheet("http://abc.com/",_currentTime);
        address _initiator=msg.sender;
        
      
        
        PredefinedNote memory _temp=PredefinedNote(_noteid,_fileId,_subject,_currentTime,_notesheet,_initiator,_recipient,"InProgress");
        instantiatedNotes[_noteid]=_temp;
        
        PredefinedNoteTracker memory _tracker=PredefinedNoteTracker(_noteid,_recipient);
        instantiatedNotesTrackers.push(_tracker);
      
        
        emit CreateResponse(_noteid,_recipient);
        return _noteid;
        
    }
   
    //Get List of noteids against employee address
    function getListOfFilesForAddress(address _address) public view returns(PredefinedNoteTracker[] memory){
        
        PredefinedNoteTracker[] memory _list=new PredefinedNoteTracker[](instantiatedNotesTrackers.length);
        
        for(uint i=0;i<instantiatedNotesTrackers.length;i++){
            
            PredefinedNoteTracker memory _temp=instantiatedNotesTrackers[i];
            if (_temp.currentOwner == _address){
                _list[i]=_temp;
            }
        }
        
        return _list;
    }
    
    //Get Predefined Notes based on noteId
    function getPredefinedNote(bytes32 _noteId) public view returns(PredefinedNote memory){
        
        return instantiatedNotes[_noteId];
    }
    
    //Function for internal usage
    function getNoteId() internal view returns(bytes32)
    {
        // increase nonce
        uint randNonce=instantiatedNotesTrackers.length+1; 
        return (keccak256(abi.encodePacked(block.timestamp,msg.sender,randNonce))) ;
    }
    
}
