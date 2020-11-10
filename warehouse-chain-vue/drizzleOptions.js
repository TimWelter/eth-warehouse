import Warehouse from '../Warehouse chain/build/contracts/Warehouse.json'

const options = {
  web3: {
    block: false,
    fallback: {
      type: 'ws',
      url: 'ws://127.0.0.1:7545'
    }
  },

  // The contracts to monitor
  contracts: [Warehouse],
//   events: {
//     // monitor SimpleStorage.StorageSet events
//     SimpleStorage: ['StorageSet']
//   },
  polls: {
    // check accounts ever 15 seconds
    accounts: 15000
  }
}

export default options