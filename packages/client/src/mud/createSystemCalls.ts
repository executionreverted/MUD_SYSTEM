/*
 * Create the system calls that the client can use to ask
 * for changes in the World state (using the System contracts).
 */

import { getComponentValue } from "@latticexyz/recs";
import { ClientComponents } from "./createClientComponents";
import { SetupNetworkResult } from "./setupNetwork";
import { singletonEntity } from "@latticexyz/store-sync/recs";
import { formatEther, parseEther } from "viem";
import { sleep } from "@latticexyz/utils";

export type SystemCalls = ReturnType<typeof createSystemCalls>;

export function createSystemCalls(
  /*
   * The parameter list informs TypeScript that:
   *
   * - The first parameter is expected to be a
   *   SetupNetworkResult, as defined in setupNetwork.ts
   *
   *   Out of this parameter, we only care about two fields:
   *   - worldContract (which comes from getContract, see
   *     https://github.com/latticexyz/mud/blob/main/templates/react/packages/client/src/mud/setupNetwork.ts#L63-L69).
   *
   *   - waitForTransaction (which comes from syncToRecs, see
   *     https://github.com/latticexyz/mud/blob/main/templates/react/packages/client/src/mud/setupNetwork.ts#L77-L83).
   *
   * - From the second parameter, which is a ClientComponent,
   *   we only care about Counter. This parameter comes to use
   *   through createClientComponents.ts, but it originates in
   *   syncToRecs
   *   (https://github.com/latticexyz/mud/blob/main/templates/react/packages/client/src/mud/setupNetwork.ts#L77-L83).
   */
  { worldContract, waitForTransaction, playerEntity, walletClient }: SetupNetworkResult,
  { Player }: ClientComponents,
) {
  const createCharacter = async (name: string) => {
    const tx = await worldContract.write.app__createPlayer([name as string]);
    await waitForTransaction(tx);
    return getComponentValue(Player, playerEntity);
  };

  const mintDevGold = async (callback: any) => {
    const tx = await worldContract.write.app__mintGold([walletClient.account.address, parseEther("1")]);
    await waitForTransaction(tx);
    await sleep(1000);
    callback();
  };

  const mintDevSilver = async (callback: any) => {
    const tx = await worldContract.write.app__mintSilver([walletClient.account.address, parseEther("1")]);
    await waitForTransaction(tx);
    await sleep(1000);
    callback();
  };

  return {
    createCharacter,
    mintDevGold,
    mintDevSilver,
  };
}
