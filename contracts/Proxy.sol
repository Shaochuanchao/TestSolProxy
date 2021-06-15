pragma solidity >=0.6.0 <=0.9.0;

abstract contract Proxy{
    
    
    function implementation()  public virtual returns (address);
    
    event Receive(address from,uint amount);
    
    
    receive() payable external{
        emit Receive(msg.sender,msg.value);
    }
    
    
    fallback() payable external{
        
        
        address  impl = implementation();
        require(impl!= address(0),"Can't be zero address");
        
        assembly {
            
            let ptr := mload(0x40)
            calldatacopy(ptr, 0, calldatasize())
            let result := delegatecall(gas(), impl, ptr, calldatasize(), 0, 0)
            let size := returndatasize()
            returndatacopy(ptr, 0, size)

            switch result
            case 0 { revert(ptr, size) }
            default { return(ptr, size) }
    
  
        }
    
        
    }
    
}