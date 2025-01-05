const {logger} = require("firebase-functions");
const {initializeApp} = require('firebase-admin/app');

initializeApp();

const {onObjectFinalized} = require("firebase-functions/v2/storage");
const {makeuppercase} = require("./uppercase"); // Import the function
const {updateuserlists} = require("./updateuserlists"); // Import the function


exports.logstore = onObjectFinalized("my-bucket", (cloudEvent) => {
    logger.log(cloudEvent);
});
exports.makeuppercase = makeuppercase;
exports.updateuserlists = updateuserlists;
