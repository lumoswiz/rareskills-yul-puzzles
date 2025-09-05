// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract Approve {
    // emit these
    function main(address token, uint256 amount) external {
        assembly {
            let p := mload(0x40)
            mstore(p, 0x095ea7b3)
            mstore(add(p, 0x20), token)
            mstore(add(p, 0x40), amount)
            let success := call(
                gas(),
                token,
                0x00,
                add(p, 0x1c),
                0x44,
                0x00,
                0x00
            )
            // approve "token" to spend "amount"
            // hint: approve has function selector 0x095ea7b3 and signature "approve(address,uint256)"
        }
    }
}
