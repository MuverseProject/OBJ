// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC20 {
    function totalSupply() external view returns (uint);

    function balanceOf(address account) external view returns (uint);

    function transfer(address recipient, uint amount) external returns (bool);

    function allowance(address owner, address spender) external view returns (uint);

    function approve(address spender, uint amount) external returns (bool);

    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);
}



pragma solidity ^0.8;

contract Stake {

    IERC20 public immutable muToken; 
  

    uint256[] public  times;

    uint256[]  public nums;

    mapping(address => bool) public whiteList;

   constructor(address _token,uint256[] memory _times,uint256[] memory _nums,address[] memory _white) {
   
        require(_times.length == _nums.length,"length error");
        require(_white.length == 2,"_white length error");
        muToken = IERC20(_token);
        times = _times;
        nums = _nums;
        whiteList[_white[0]] = true;
        whiteList[_white[1]] = true;
    }
    function  getReward() external 
     {
        require(whiteList[msg.sender],"You don't have permission");
        uint num = 0;
        for(uint256 i=0;i<times.length;i++){
           if(block.timestamp > times[i]){
                if( nums[i] > 0){
                    num += nums[i];
                    nums[i] = 0;      
                }              
            }else{
                break;
            }
        }
        
        require(num > 0, "There is no reward to claim");
        muToken.transfer(msg.sender, num);
        
    }

    function test () public view returns (uint256) {
        require(whiteList[msg.sender],"You don't have permission");
        uint num = 0;
        for(uint256 i=0;i<times.length;i++){
           if(block.timestamp > times[i]){
                if( nums[i] > 0){
           
                }              
            }else{
                break;
            }
        }

        return num;
    }

   

}

