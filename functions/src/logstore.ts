import {onObjectFinalized} from "firebase-functions/v2/storage";
import {logger} from "firebase-functions";

export const logstore = onObjectFinalized("my-bucket", (cloudEvent) => {
  logger.log(cloudEvent);
});

