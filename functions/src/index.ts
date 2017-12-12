import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

// // Start writing Firebase Functions
// // https://firebase.google.com/functions/write-firebase-functions
//
// export const helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });


admin.initializeApp(functions.config().firebase);

export const tasksCounter =
    functions.firestore.document('lists/{listId}/tasks/{taskId}')
        .onWrite(async (event: functions.Event<functions.firestore.DeltaDocumentSnapshot>) => {
            const firestore = admin.firestore();
            const listGet = firestore.collection('lists').doc(event.params.listId).get();
            const tasksGet = firestore.collection(`lists/${event.params.listId}/tasks`).get();
            return Promise.all([listGet, tasksGet]).then(result => {
                const list = result[0];
                const tasks = result[1];

                return list.ref.set({ tasksCount: tasks.size });
            });
        });