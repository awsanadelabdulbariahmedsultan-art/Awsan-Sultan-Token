.env
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract AwsanSultanToken is ERC20, ERC20Burnable, Ownable {
    
    // تم تحديد من ينشر العقد كمالك تلقائي
    constructor() ERC20("Awsan Sultan Token", "AST") Ownable(msg.sender) {
        // صك مليار عملة وإرسالها لمحفظة المنشئ
        _mint(msg.sender, 1000000000 * 10 ** decimals());
    }
}
