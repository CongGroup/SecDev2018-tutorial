pragma solidity ^0.4.25;

library Helpers {
    // returns whether `array` contains `value`.
    function addressArrayContains(address[] array, address value) internal pure returns (bool) {
        for (uint256 i = 0; i < array.length; i++) {
            if (array[i] == value) {
                return true;
            }
        }
        return false;
    }

    function indexOfElement(address[] array, address value) internal pure returns (int) {
        for (uint256 i = 0; i< array.length; ++i) {
            if(array[i] == value ) {
                return int(i);
            }
        }
        return -1;
    }

    // returns the digits of `inputValue` as a string.
    // example: `uintToString(12345678)` returns `"12345678"`
    function uintToString(uint256 inputValue) internal pure returns (string) {
        // figure out the length of the resulting string
        uint256 length = 0;
        uint256 currentValue = inputValue;
        do {
            length++;
            currentValue /= 10;
        } while (currentValue != 0);
        // allocate enough memory
        bytes memory result = new bytes(length);
        // construct the string backwards
        uint256 i = length - 1;
        currentValue = inputValue;
        do {
            result[i--] = byte(48 + currentValue % 10);
            currentValue /= 10;
        } while (currentValue != 0);
        return string(result);
    }

    // returns whether signatures (whose components are in `vs`, `rs`, `ss`)
    // contain `requiredSignatures` distinct correct signatures
    // where signer is in `allowed_signers`
    // that signed `message`
    function hasEnoughValidSignatures(bytes message, uint8[] vs, bytes32[] rs, bytes32[] ss, address[] allowed_signers, uint256 requiredSignatures) internal pure returns (bool) {
        // not enough signatures
        if (vs.length < requiredSignatures) {
            return false;
        }

        bytes32 hash = MessageSigning.hashMessage(message);
        address [] memory encountered_addresses = new address[](allowed_signers.length);

        for (uint256 i = 0; i < requiredSignatures; i++) {
            address recovered_address = ecrecover(hash, vs[i], rs[i], ss[i]);
            // only signatures by addresses in `addresses` are allowed
            if (!addressArrayContains(allowed_signers, recovered_address)) {
                return false;
            }
            // duplicate signatures are not allowed
            if (addressArrayContains(encountered_addresses, recovered_address)) {
                return false;
            }
            encountered_addresses[i] = recovered_address;
        }
        return true;
    }

}


library Message {
    // layout of message :: bytes:
    // offset 32: 0-32:: bytes32 - transaction hash 
    // offset 52: 32-52:: address recipient address
    // offset 84: 52-84:: uint256 (big endian) - value

    function getTransactionHash(bytes message) internal pure returns (bytes32) {
        bytes32 hash;
        assembly {
            hash := mload(add(message, 32))
        }
        return hash;
    }

    function getRecipients(bytes message) internal pure returns (address) {
        address recipient;
        assembly {
            recipient := mload(add(message, 52))
        }
        return recipient;
    }

    function getValues(bytes message) internal pure returns (uint256) {
        uint256 value;
        assembly {
            value := mload(add(message, 84))
        }
        return value;
    }
}


library MessageSigning {
    function recoverAddressFromSignedMessage(bytes signature, bytes message) internal pure returns (address) {
        require(signature.length == 65);
        bytes32 r;
        bytes32 s;
        bytes1 v;
        assembly {
            r := mload(add(signature, 0x20))
            s := mload(add(signature, 0x40))
            v := mload(add(signature, 0x60))
        }
        return ecrecover(hashMessage(message), uint8(v), r, s);
    }

    function hashMessage(bytes message) internal pure returns (bytes32) {
        bytes memory prefix = "\x19Ethereum Signed Message:\n";
        return keccak256(abi.encodePacked(prefix, Helpers.uintToString(message.length), message));
    }
}