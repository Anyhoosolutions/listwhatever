const {logger} = require("firebase-functions");

const {onDocumentWritten} = require("firebase-functions/v2/firestore");
const {getFirestore} = require("firebase-admin/firestore");
const {initializeApp} = require('firebase-admin/app');

initializeApp();
const db = getFirestore();

exports.updateuserlists = onDocumentWritten("/lists/{listId}", (event) => {

    const listInfo =  event.data.after.data();
    logger.log("listInfo.name", listInfo.name);
   
    if (listInfo == undefined) {
      logger.log('Could not get data from list');
      return;
    }
    logger.log(`listInfo: ${JSON.stringify(listInfo)}`);
  
    const userListIds = [listInfo.ownerId].concat(Object.keys(listInfo.sharedWith));
    logger.log(`userListIds: ${JSON.stringify(userListIds)}`);
  
    for (const userListId of userListIds) {
      logger.log(`userListId: ${userListId}`);
  
      const collectionRef = db.collection('users').doc(userListId).collection('lists');
  
      const query = collectionRef.where('listId', '==', listInfo.id);
  
      query.get().then((querySnapshot) => {
        logger.log(`querySnapshot: ${querySnapshot}`);

        for (const doc of querySnapshot.docs) {
            const docId = doc.id;
            const userList = doc.data();
    
            userList.listName = listInfo.name;
            userList.listType = listInfo.listType;
            userList.imageFilename = listInfo.imageFilename;
    
            const userListPath = `users/${userListId}/lists/${docId}`;
            const userListDoc = db.doc(userListPath);
            userListDoc.set(userList, {merge: true});
        }
      });
    }
});
