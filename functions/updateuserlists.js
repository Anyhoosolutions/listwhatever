const {logger} = require("firebase-functions");

const {onDocumentWritten} = require("firebase-functions/v2/firestore");
const {getFirestore} = require("firebase-admin/firestore");

const db = getFirestore();

exports.updateuserlists = onDocumentWritten("/lists/{listId}", (event) => {
    logger.log('');
    logger.log('');

    const listId = event.params.listId; // Get the document ID from the event parameters
    logger.log('listId: ', listId);
    const listInfo =  event.data.after.data();
   
    if (listInfo == undefined) {
      const beforeListInfo =  event.data.before.data();
      logger.log('beforeListInfo: ', beforeListInfo);
      deleteUserLists(listId, beforeListInfo);
    } else {
      updateuserlists(listId, listInfo);
    }
});

function updateuserlists(listId, listInfo) {
    logger.log(`listInfo: ${JSON.stringify(listInfo)}`);
  
    const userListIds = [listInfo.ownerId].concat(Object.keys(listInfo.sharedWith));
    logger.log(`userListIds: ${JSON.stringify(userListIds)}`);
  
    for (const userListId of userListIds) {
      logger.log(`userListId: ${userListId}`);
  
      const path = `users/${userListId}/lists`;
      logger.log('path: ', path);
      const collectionRef = db.collection(path);
  
      const query = collectionRef.where('listId', '==', listId);
  
      query.get().then((querySnapshot) => {
        logger.log(`querySnapshot.docs: ${querySnapshot.docs.length}`);

        for (const doc of querySnapshot.docs) {
            const docId = doc.id;
            const userList = doc.data();
    
            userList.listName = listInfo.name;
            userList.imageFilename = listInfo.imageFilename;
    
            const userListPath = `users/${userListId}/lists/${docId}`;

            const userListDoc = db.doc(userListPath);
            userListDoc.set(userList, {merge: true});
        }
      });
    }
}


function deleteUserLists(listId, listInfo) {
    const userIds = [listInfo.ownerId].concat(Object.keys(listInfo.sharedWith));
    logger.log(`userIds: ${JSON.stringify(userIds)}`);
  
    for (const userId of userIds) {
      logger.log(`userId: ${userId}`);
  
      const collectionRef = db.collection('users').doc(userId).collection('lists');
  
      const query = collectionRef.where('listId', '==', listId);
  
      query.get().then((querySnapshot) => {
        logger.log(`querySnapshot: ${querySnapshot}`);

        for (const doc of querySnapshot.docs) {
            const docId = doc.id;
    
            const userListPath = `users/${userId}/lists/${docId}`;

            const userListDoc = db.doc(userListPath);
            userListDoc.delete();
        }
      });
    }

}