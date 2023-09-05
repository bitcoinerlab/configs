#!/bin/bash
#--openHandlesTimeout=4000 is important here because of native fetch leaves open handles for a few seconds even after correct await response - even when all fetch requests are correctly awaited and the responses are consumed, the underlying connections created by Node.js can remain open due to connection pooling, which Jest interprets as an open handle. Alternatively, put this into the code: await new Promise(resolve => setTimeout(resolve, 4000));",

npm run lint && npm run build && npm run tester && NODE_OPTIONS=\"--experimental-fetch\" jest --openHandlesTimeout=4000 --
