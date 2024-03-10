/**
 * Import function triggers from their respective submodules:
 *
 * import {onCall} from "firebase-functions/v2/https";
 * import {onDocumentWritten} from "firebase-functions/v2/firestore";
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

import { onRequest } from "firebase-functions/v2/https";
import * as firebase from "firebase-admin";
import * as logger from "firebase-functions/logger";
// import { Place } from "./dtos/place";
import { Category } from "./models/category";
import * as categoryService from "./services/categoryService";

// Start writing functions
// https://firebase.google.com/docs/functions/typescript

firebase.initializeApp();

export const helloWorld = onRequest((request, response) => {
  logger.info("Hello logs!", { structuredData: true });
  response.send("Hello from Firebase!");
});

export const importPlaces = onRequest((request, response) => {
  logger.info("Recevid request to insert data", { structuredData: true });

  // const datas = request.body as Place[];


  response.send("Hello from Firebase!" + JSON.stringify(request.body));
});

export const importCategories = onRequest(async (request, response) => {
  logger.info("Recevid request to insert data", { structuredData: true });

  const datas = request.body as Category[];
  const result = await categoryService.insertUpdateCategories(datas);
  response.status(200).send(result);
});
