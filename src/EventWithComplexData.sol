// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract EventWithComplexData {
    // EMIT ME!!!
    event MyEvent(address indexed emitter, address[] players, uint256[] scores);

    bytes32 private constant _MY_EVENT_SIGNATURE =
        0x06af3d8f9866c9f54dcf425d9da9f75849af90454a25bca9df5fb24d80683e6a;

    function main(
        address emitter,
        address[] memory players,
        uint256[] memory scores
    ) external {
        assembly {
            let pOff := calldataload(0x24)
            let pPtr := add(0x04, pOff)
            let pLen := calldataload(pPtr)

            let sOff := calldataload(0x44)
            let sPtr := add(0x04, sOff)
            let sLen := calldataload(sPtr)

            let pTail := add(0x20, shl(5, pLen))
            let sTail := add(0x20, shl(5, sLen))

            pOff := 0x40
            sOff := add(0x40, add(0x20, shl(5, pLen)))

            let p := mload(0x40)
            mstore(p, pOff)
            mstore(add(p, 0x20), sOff)
            calldatacopy(add(p, 0x40), pPtr, pTail)
            calldatacopy(add(add(p, 0x40), pTail), sPtr, sTail)

            let l := add(0x40, add(pTail, sTail))
            log2(p, l, _MY_EVENT_SIGNATURE, emitter)

            // emit the `MyEvent(address,address[],uint256[])` event
            // Hint: Use `log2` to emit the event with the hash as the topic0 and `emitter` as topic1, then the data
        }
    }
}
