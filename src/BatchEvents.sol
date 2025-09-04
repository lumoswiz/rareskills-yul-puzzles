// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract BatchEvents {
    // EMIT ME!!!
    event MyEvent(address indexed emitter, bytes32 indexed id, uint256 num);

    bytes32 private constant _MY_EVENT_SIGNATURE =
        0x044d482819499c9d5fde1245ce63873b1259fc52fc78651ccdcdf7392637d374;

    function main(
        address[] memory emitters,
        bytes32[] memory ids,
        uint256[] memory nums
    ) external {
        assembly {
            let ePtr := add(0x04, calldataload(0x04))
            let iPtr := add(0x04, calldataload(0x24))
            let nPtr := add(0x04, calldataload(0x44))

            let len := calldataload(ePtr)
            let p := mload(0x40)
            // prettier-ignore
            for { let i := 0 } lt(i, len) { i := add(i, 1) } {
                let off := shl(5, i)
                let em := calldataload(add(add(ePtr, 0x20), off))
                let id := calldataload(add(add(iPtr, 0x20), off))
                let nu := calldataload(add(add(nPtr, 0x20), off))

                mstore(p, nu)
                log3(p, add(p, 0x20), _MY_EVENT_SIGNATURE, em, id)
            }

            // emit the `MyEvent(address,bytes32,uint256)` event
            // Assuming all arrays (emitters, ids, and nums) are of equal length.
            // iterate over the set of parameters and emit events based on the array length.
        }
    }
}
