// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

/**
 * Realised I probably shouldn't be overwriting the free memory pointer:
 *   - https://noxx.substack.com/p/evm-deep-dives-the-path-to-shadowy-d6b
 */

contract EventWithMultipleData {
    // EMIT ME!!!
    event MyEvent(address emitter, uint256 num, bool isActive);

    bytes32 private constant _MY_EVENT_SIGNATURE =
        0x532e3b2a35ca0879a4b08813e66d07f972db1900da196cbdc7e31d4d1bfc657f;

    function main(address emitter, uint256 num, bool isActive) external {
        assembly {
            let p := mload(0x40)
            calldatacopy(p, 0x04, 0x60)
            log1(p, 0x60, _MY_EVENT_SIGNATURE)
            mstore(0x40, add(p, 0x60))
            // emit the `MyEvent(address,uint256,bool)` event
            // the event has three fields of data: an address, a uint256, and a bool
            // use `log1` to emit the event with one topic (the event signature hash) and the data payload
            // Hint: Pack the `emitter`, `num`, and `isActive` values in memory for the data payload
            // Note: Ensure the data layout in memory matches the event parameter order
        }
    }
}
