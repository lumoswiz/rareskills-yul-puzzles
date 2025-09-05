// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract BasicBank {
    // emit these
    event Deposit(address indexed depositor, uint256 amount);
    event Withdraw(address indexed withdrawer, uint256 amount);

    error InsufficientBalance();

    mapping(address => uint256) public balances;

    function deposit() external payable {
        bytes32 depositSelector = Deposit.selector;
        assembly {
            let value := callvalue()
            let sender := caller()

            mstore(0x00, sender)
            let slot := keccak256(0x00, 0x40)
            sstore(slot, add(sload(slot), value))

            mstore(0x00, value)
            log2(0x00, 0x20, depositSelector, sender)

            // emit Deposit(msg.sender, msg.value)
            // increment the balance of the msg.sender by msg.value
        }
    }

    function withdraw(uint256 amount) external returns (uint256 bal) {
        bytes32 withdrawSelector = Withdraw.selector;
        bytes4 insufficientBalanceSelector = InsufficientBalance.selector;
        assembly {
            let sender := caller()

            mstore(0x00, sender)
            let slot := keccak256(0x00, 0x40)

            bal := sload(slot)
            if lt(bal, amount) {
                let p := mload(0x40)
                mstore(p, insufficientBalanceSelector)
                revert(p, add(p, 0x20))
            }
            bal := sub(bal, amount)
            sstore(slot, bal)

            let success := call(gas(), sender, amount, 0x00, 0x00, 0x00, 0x00)

            mstore(0x00, amount)
            log2(0x00, 0x20, withdrawSelector, sender)

            // emit Withdraw(msg.sender, amount)
            // if the balance is less than amount, revert InsufficientBalance()
            // decrement the balance of the msg.sender by amount
            // send the amount to the msg.sender
        }
    }
}
