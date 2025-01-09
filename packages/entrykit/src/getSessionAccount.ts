import { Address, Chain, Client, Transport } from "viem";
import { SmartAccount } from "viem/account-abstraction";
import { toSimpleSmartAccount } from "permissionless/accounts";
import { getSessionSigner } from "./getSessionSigner";

export async function getSessionAccount<chain extends Chain>({
  client,
  userAddress,
}: {
  client: Client<Transport, chain>;
  userAddress: Address;
}): Promise<SmartAccount> {
  const sessionSigner = getSessionSigner(userAddress);
  return await toSimpleSmartAccount({ client, owner: sessionSigner });
}
