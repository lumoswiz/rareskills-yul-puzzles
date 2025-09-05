// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract PaymentSplitter {
    function main(address[] calldata recipients) external payable {
        assembly {
            let off := calldataload(0x04)
            let ptr := add(0x04, off)
            let len := calldataload(ptr)

            let v := div(selfbalance(), len)
            // prettier-ignore
            for { let i := 0 } lt(i, len) { i := add(i, 1) } {
                let recipient := calldataload(add(add(ptr, 0x20), shl(5, i)))
                let r := call(gas(), recipient, v, 0x00, 0x00, 0x00, 0x00)
            }

            // send the entire contract balance to the recipients
            // each recipient gets balance / recipients.length
        }
    }
}
