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