import { client, ALGOLIA_INDEX_NAME } from "../common/algolia";
import { functions } from "../common/firebase";
import { Change, CloudFunction } from "firebase-functions";
import { DocumentSnapshot } from "firebase-functions/lib/providers/firestore";


class Handler {
    onMetadataCreated: CloudFunction<DocumentSnapshot>;
    onMetadataUpdated: CloudFunction<Change<DocumentSnapshot>>;
    onMetadataDeleted: CloudFunction<DocumentSnapshot>;

    constructor() {
        this.onMetadataCreated = functions.firestore
            .document('packages/{packageId}')
            .onCreate((snap, context) => {
                // Get the note document
                const pack = snap.data();
                // Add an 'objectID' field which Algolia requires
                pack.objectID = snap.id;
                // Write to the algolia index
                const index = client.initIndex(ALGOLIA_INDEX_NAME);
                return index.saveObject(pack);
            });
        this.onMetadataUpdated = functions.firestore
            .document('packages/{packageId}')
            .onUpdate((change, context) => {
                const index = client.initIndex(ALGOLIA_INDEX_NAME);
                return index.deleteObject(change.before.id)
                    .then(() => {
                        // Get the note document
                        const pack = change.after.data();
                        // Add an 'objectID' field which Algolia requires
                        pack.objectID = change.after.id;
                        // Write to the algolia index
                        return index.saveObject(pack);
                    })
                    .catch((err) => {
                        console.error(err);
                    });
            });
        this.onMetadataDeleted = functions.firestore
            .document('packages/{packageId}')
            .onDelete((snap, context) => {
                const index = client.initIndex(ALGOLIA_INDEX_NAME);
                return index.deleteObject(snap.id);
            });
    }
}
export default new Handler();