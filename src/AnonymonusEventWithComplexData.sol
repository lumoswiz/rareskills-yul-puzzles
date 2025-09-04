// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract AnonymonusEventWithComplexData {
    enum Gender {
        Male,
        Female,
        Trans
    }

    struct Person {
        string name;
        uint256 age;
        Gender gender;
    }

    // EMIT ME!!!
    event MyEvent(address indexed emitter, bytes32 indexed id, Person person);

    function main(address emitter, bytes32 id, Person memory person) external {
        assembly {
            let personOff := calldataload(0x44)
            let personPtr := add(0x04, personOff)
            let personLen := sub(calldatasize(), personPtr)

            let p := mload(0x40)
            mstore(p, 0x20)
            calldatacopy(add(p, 0x20), personPtr, personLen)
            log3(p, add(0x20, personLen), 0x00, emitter, id)

            // emit the `MyEvent(address,bytes32,(string,uint256,uint8))` event.
            // Anonymous events don't have the event signature (topic0) included.
            // Hint: how the `Person` struct is encoded in mem:
            //          - string offset
            //          - string length offset
            //          - age
            //          - gender
            //          - name length
            //          - name
        }
    }
}
