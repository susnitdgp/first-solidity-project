//SPDX-License-Identifier:UNLICENSED
pragma solidity ^0.8.7;

contract FirstContract{
    
    string name;
    uint a;
    
    function getName() external view returns(string memory){
        return name;
    }
    
    function setName(string memory _name) external{
        name=_name;
    }
    
    function setInteger(uint _a) external {
        
        if(_a !=10){
            a=_a;
        }else{
            revert("Value 10  is not accepted");
        }
    }
    
}
