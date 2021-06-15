pragma solidity >=0.6.0 <=0.9.0;


library Address{
    
    
    
    function isContact(address account) internal view returns (bool){
        
        uint256 size;
        assembly{
            size:= extcodesize(account)
        }
        return size>0;
        
    }
    
}