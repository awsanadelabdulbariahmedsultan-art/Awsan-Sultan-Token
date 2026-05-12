// SPDX-License-Identifier: MIT
/**
 * @title Awsan Sultan Token (AST)
 * @dev Official Smart Contract with Institutional Controls
 * 
 * 📜 INTELLECTUAL PROPERTY & COPYRIGHT NOTICE:
 * -----------------------------------------------------------------------
 * Copyright (c) 2026 Eng. Awsan Adel Abdulbari Ahmed Sultan. All Rights Reserved.
 * Developer: Eng. Awsan Adel Abdulbari Ahmed Sultan
 * Country: Yemen
 * National ID: 01010305468
 * Phone: +967 777852433
 * Email: awsan.sultan@gmail.com
 * LinkedIn: https://www.linkedin.com/in/awsan-adel-abdulbari-ahmed-sultan-8aa5a1a9
 * -----------------------------------------------------------------------
 */

pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract AwsanSultanToken is ERC20, ERC20Burnable, Ownable {

    // بيانات المالك والملكية الفكرية المخزنة على البلوكشين
    string public constant DEVELOPER = "Eng. Awsan Adel Abdulbari Ahmed Sultan";
    string public constant LICENSE_ID = "YEM-01010305468";

    // ميزة الرقابة المالية (القائمة السوداء) للامتثال للبنك المركزي
    mapping(address => bool) private _blacklist;

    event AccountFrozen(address indexed account);
    event AccountUnfrozen(address indexed account);

    constructor() ERC20("Awsan Sultan Token", "AST") Ownable(msg.sender) {
        // صك مليار عملة وإرسالها لمحفظة المؤسس المهندس أوسان
        _mint(msg.sender, 1000000000 * 10 ** decimals());
    }

    // وظائف التحكم والرقابة (خاصة بالمالك فقط)
    function freezeAccount(address account) public onlyOwner {
        _blacklist[account] = true;
        emit AccountFrozen(account);
    }

    function unfreezeAccount(address account) public onlyOwner {
        _blacklist[account] = false;
        emit AccountUnfrozen(account);
    }

    // التحقق من حالة الحساب قبل أي عملية نقل
    function _update(address from, address to, uint256 value) internal override {
        require(!_blacklist[from], "AST: Action denied. Source account is frozen for compliance.");
        require(!_blacklist[to], "AST: Action denied. Destination account is frozen for compliance.");
        super._update(from, to, value);
    }

    /**
     * @dev دالة لاستعادة ملكية العقد أو التحقق من بيانات المطور برمجياً
     */
    function getDeveloperInfo() public pure returns (string memory, string memory, string memory) {
        return (DEVELOPER, "ID: 01010305468", "Email: awsan.sultan@gmail.com");
    }
}
