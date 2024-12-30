const {logger} = require("firebase-functions");

const {onDocumentCreated} = require("firebase-functions/v2/firestore");

exports.makeuppercase = onDocumentCreated("/messages/{documentId}", (event) => {
    const original = event.data.data().original;
    logger.log("Uppercasing", event.params.documentId, original);
    const uppercase = original.toUpperCase();
    return event.data.ref.set({uppercase}, {merge: true});
  });