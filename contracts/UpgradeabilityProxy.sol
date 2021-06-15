pragma solidity >=0.6.0 <=0.9.0;

import './Proxy.sol';

contract UpgrateabilityProxy is Proxy{
    
    event Upgrate(address impl);
    
    
    //obtained as bytes32(uint256(keccak256('eip1967.proxy.implementation')) - 1)
    bytes32 private constant  implPosition = 0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc;
    
    
    function implementation() public override view returns (address impl){
        
        assembly{
            
            impl:= sload(implPosition)
            
        }
        
        
    }
    
    
    function setImpl(address newImpl) internal{
        assembly{
            sstore(implPosition,newImpl)
        }
    }
    
    function _upgrateTo(address newImpl) internal{
        
        address cur = implementation();
        require(cur != newImpl);
        setImpl(newImpl);
        emit Upgrate(newImpl);
        
    }
    
    
}
