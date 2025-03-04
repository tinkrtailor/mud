// SPDX-License-Identifier: MIT
pragma solidity >=0.8.24;

/* Autogenerated file. Do not edit manually. */

import { BalanceTransferSystem } from "../../../modules/init/implementations/BalanceTransferSystem.sol";
import { ResourceId } from "@latticexyz/store/src/ResourceId.sol";
import { revertWithBytes } from "../../../revertWithBytes.sol";
import { IWorldCall } from "../../../IWorldKernel.sol";
import { SystemCall } from "../../../SystemCall.sol";
import { WorldContextConsumerLib } from "../../../WorldContext.sol";
import { Systems } from "../../../codegen/tables/Systems.sol";
import { StoreSwitch } from "@latticexyz/store/src/StoreSwitch.sol";

type BalanceTransferSystemType is bytes32;

// equivalent to WorldResourceIdLib.encode({ typeId: RESOURCE_SYSTEM, namespace: "", name: "BalanceTransfer" }))
BalanceTransferSystemType constant balanceTransferSystem = BalanceTransferSystemType.wrap(
  0x7379000000000000000000000000000042616c616e63655472616e7366657200
);

struct CallWrapper {
  ResourceId systemId;
  address from;
}

struct RootCallWrapper {
  ResourceId systemId;
  address from;
}

/**
 * @title BalanceTransferSystemLib
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @dev This library is automatically generated from the corresponding system contract. Do not edit manually.
 */
library BalanceTransferSystemLib {
  error BalanceTransferSystemLib_CallingFromRootSystem();

  function transferBalanceToNamespace(
    BalanceTransferSystemType self,
    ResourceId fromNamespaceId,
    ResourceId toNamespaceId,
    uint256 amount
  ) internal {
    return
      CallWrapper(self.toResourceId(), address(0)).transferBalanceToNamespace(fromNamespaceId, toNamespaceId, amount);
  }

  function transferBalanceToAddress(
    BalanceTransferSystemType self,
    ResourceId fromNamespaceId,
    address toAddress,
    uint256 amount
  ) internal {
    return CallWrapper(self.toResourceId(), address(0)).transferBalanceToAddress(fromNamespaceId, toAddress, amount);
  }

  function transferBalanceToNamespace(
    CallWrapper memory self,
    ResourceId fromNamespaceId,
    ResourceId toNamespaceId,
    uint256 amount
  ) internal {
    // if the contract calling this function is a root system, it should use `callAsRoot`
    if (address(_world()) == address(this)) revert BalanceTransferSystemLib_CallingFromRootSystem();

    bytes memory systemCall = abi.encodeCall(
      _transferBalanceToNamespace_ResourceId_ResourceId_uint256.transferBalanceToNamespace,
      (fromNamespaceId, toNamespaceId, amount)
    );
    self.from == address(0)
      ? _world().call(self.systemId, systemCall)
      : _world().callFrom(self.from, self.systemId, systemCall);
  }

  function transferBalanceToAddress(
    CallWrapper memory self,
    ResourceId fromNamespaceId,
    address toAddress,
    uint256 amount
  ) internal {
    // if the contract calling this function is a root system, it should use `callAsRoot`
    if (address(_world()) == address(this)) revert BalanceTransferSystemLib_CallingFromRootSystem();

    bytes memory systemCall = abi.encodeCall(
      _transferBalanceToAddress_ResourceId_address_uint256.transferBalanceToAddress,
      (fromNamespaceId, toAddress, amount)
    );
    self.from == address(0)
      ? _world().call(self.systemId, systemCall)
      : _world().callFrom(self.from, self.systemId, systemCall);
  }

  function transferBalanceToNamespace(
    RootCallWrapper memory self,
    ResourceId fromNamespaceId,
    ResourceId toNamespaceId,
    uint256 amount
  ) internal {
    bytes memory systemCall = abi.encodeCall(
      _transferBalanceToNamespace_ResourceId_ResourceId_uint256.transferBalanceToNamespace,
      (fromNamespaceId, toNamespaceId, amount)
    );
    SystemCall.callWithHooksOrRevert(self.from, self.systemId, systemCall, msg.value);
  }

  function transferBalanceToAddress(
    RootCallWrapper memory self,
    ResourceId fromNamespaceId,
    address toAddress,
    uint256 amount
  ) internal {
    bytes memory systemCall = abi.encodeCall(
      _transferBalanceToAddress_ResourceId_address_uint256.transferBalanceToAddress,
      (fromNamespaceId, toAddress, amount)
    );
    SystemCall.callWithHooksOrRevert(self.from, self.systemId, systemCall, msg.value);
  }

  function callFrom(BalanceTransferSystemType self, address from) internal pure returns (CallWrapper memory) {
    return CallWrapper(self.toResourceId(), from);
  }

  function callAsRoot(BalanceTransferSystemType self) internal view returns (RootCallWrapper memory) {
    return RootCallWrapper(self.toResourceId(), WorldContextConsumerLib._msgSender());
  }

  function callAsRootFrom(BalanceTransferSystemType self, address from) internal pure returns (RootCallWrapper memory) {
    return RootCallWrapper(self.toResourceId(), from);
  }

  function toResourceId(BalanceTransferSystemType self) internal pure returns (ResourceId) {
    return ResourceId.wrap(BalanceTransferSystemType.unwrap(self));
  }

  function fromResourceId(ResourceId resourceId) internal pure returns (BalanceTransferSystemType) {
    return BalanceTransferSystemType.wrap(resourceId.unwrap());
  }

  function getAddress(BalanceTransferSystemType self) internal view returns (address) {
    return Systems.getSystem(self.toResourceId());
  }

  function _world() private view returns (IWorldCall) {
    return IWorldCall(StoreSwitch.getStoreAddress());
  }
}

/**
 * System Function Interfaces
 *
 * We generate an interface for each system function, which is then used for encoding system calls.
 * This is necessary to handle function overloading correctly (which abi.encodeCall cannot).
 *
 * Each interface is uniquely named based on the function name and parameters to prevent collisions.
 */

interface _transferBalanceToNamespace_ResourceId_ResourceId_uint256 {
  function transferBalanceToNamespace(ResourceId fromNamespaceId, ResourceId toNamespaceId, uint256 amount) external;
}

interface _transferBalanceToAddress_ResourceId_address_uint256 {
  function transferBalanceToAddress(ResourceId fromNamespaceId, address toAddress, uint256 amount) external;
}

using BalanceTransferSystemLib for BalanceTransferSystemType global;
using BalanceTransferSystemLib for CallWrapper global;
using BalanceTransferSystemLib for RootCallWrapper global;
