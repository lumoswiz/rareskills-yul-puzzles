// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract SimpleCall {
    function main(address t) external payable {
        assembly {
            mstore(0x40, 0xc2985578)
            let success := call(gas(), t, callvalue(), 0x5c, 0x04, 0xe0, 0x00)
            // call "t.foo()"
            // hint: "foo()" has function selector 0xc2985578
        }
    }
}
