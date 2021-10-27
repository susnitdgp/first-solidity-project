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
    
    
    function uploadSingleFile(string memory _name,string memory _mime, string memory _ipfsUrl) external returns (bool){
        annexure memory _temp=annexure(_name,_mime,_ipfsUrl);
        uploadedAnnexure.push(_temp);
        return true;
    }
    
    function getAllFiles() external view returns(annexure[] memory){
        return uploadedAnnexure;
    }
    
}