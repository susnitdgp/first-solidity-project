//SPDX-License-Identifier:UNLICENSED
pragma solidity ^0.8.7;

contract FirstContract{
    
    string name;
    
    
    function getName() external view returns(string memory){
        return name;
    }
    
    function setName(string memory _name) external{
        name=_name;
    }
    
   
    
}
