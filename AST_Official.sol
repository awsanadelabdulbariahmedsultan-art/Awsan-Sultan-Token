// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// استيراد المكتبات العالمية للأمان
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract AwsanSultanToken is ERC20, ERC20Burnable, Ownable {

    // ميزة إضافية للبنك المركزي: تجميد الحسابات المشبوهة
    mapping(address => bool) private _blacklist;

    event AccountFrozen(address indexed account);
    event AccountUnfrozen(address indexed account);

    constructor() ERC20("Awsan Sultan Token", "AST") Ownable(msg.sender) {
        // صك مليار عملة وإرسالها لمحفظة المؤسس عند الإطلاق
        _mint(msg.sender, 1000000000 * 10 ** decimals());
    }

    // وظيفة للتحكم في الحسابات (لأغراض قانونية)
    function freezeAccount(address account) public onlyOwner {
        _blacklist[account] = true;
        emit AccountFrozen(account);
    }

    function unfreezeAccount(address account) public onlyOwner {
        _blacklist[account] = false;
        emit AccountUnfrozen(account);
    }

    // تعديل وظيفة النقل للتأكد من أن الحساب ليس مجمداً
    function _update(address from, address to, uint256 value) internal override {
        require(!_blacklist[from], "AST: Sender account is frozen");
        require(!_blacklist[to], "AST: Receiver account is frozen");
        super._update(from, to, value);
    }
}
