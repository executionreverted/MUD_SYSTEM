import * as viem_chains from 'viem/chains';
import { Chain } from 'viem/chains';
import * as viem from 'viem';
import * as viem_experimental from 'viem/experimental';
import * as viem_op_stack from 'viem/op-stack';

const eclipseTestnet = {
    iconUrls: ["https://redstone.xyz/chain-icons/garnet.png"],
    indexerUrl: "http://localhost:3001",
    blockExplorers: {
        default: {
            name: "Avalanche Subnet Explorer",
            url: "https://subnets-test.avax.network/eclipsecha/",
        },
    },
    contracts: {

    },
    id: 555666,
    name: "Eclipse Testnet",
    nativeCurrency: {
        name: "Eclipse"
        ,
        symbol: "ECL",
        decimals: 18
    },
    rpcUrls: {
        default: {
            http: ["https://subnets.avax.network/eclipsecha/testnet/rpc"],
            webSocket: ["wss://subnets.avax.network/eclipsecha/testnet/ws"],
        },
    },
    sourceId: 17000,
    testnet: true,

};

export default eclipseTestnet