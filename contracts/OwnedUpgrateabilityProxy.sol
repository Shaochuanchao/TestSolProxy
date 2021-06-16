pragma solidity >=0.6.0 <=0.9.0;

contract OwendUpgrateabilityProxy{
    
    
    
    event OwenshipTranfer(address pre,address cur);
    
    //obtained as bytes32(uint256(keccak256('eip1967.proxy.admin')) - 1)
    bytes32 private constant proxyOwnerPosition = 0xb53127684a568b3173ae13b9f8a6016e243e63b6e8ee1178d6a717850b5d6103;
    
    
    
    modifier onlyOwner(){
        require(msg.sender == proxyOwner(),"Only owner");
        _;
    } 
    
    
    function setPrxyOwner(address owner) internal {
        assembly{
            sstore(proxyOwnerPosition,owner)
        }
    }
    
    function proxyOwner() public view returns(address owner){
        assembly{
           owner :=  sload(proxyOwnerPosition)
        }
    }
    
    
    function upgrateTo(address newOwner) external  onlyOwner{
        
        require(newOwner != address(0));
        address  pre = proxyOwner();
        setPrxyOwner(newOwner);
        
        emit OwenshipTranfer(pre,newOwner);
        
    }
    
    
}