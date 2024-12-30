
const {logger} = require("firebase-functions");
const {onObjectFinalized} = require("firebase-functions/v2/storage");
const {onDocumentCreated} = require("firebase-functions/v2/firestore");
const {getFirestore} = require("firebase-admin/firestore");

exports.logstore = onObjectFinalized("my-bucket", (cloudEvent) => {
    logger.log(cloudEvent);
});
exports.makeuppercase = onDocumentCreated("/messages/{documentId}", (event) => {
    const original = event.data.data().original;
    logger.log("Uppercasing", event.params.documentId, original);
    const uppercase = original.toUpperCase();
    return event.data.ref.set({uppercase}, {merge: true});
  });