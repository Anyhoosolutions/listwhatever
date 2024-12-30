
const {logger} = require("firebase-functions");
const {onObjectFinalized} = require("firebase-functions/v2/storage");
const {makeuppercase} = require("./uppercase"); // Import the function

exports.logstore = onObjectFinalized("my-bucket", (cloudEvent) => {
    logger.log(cloudEvent);
});
exports.makeuppercase = makeuppercase;
