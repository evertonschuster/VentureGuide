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
import * as markerService from "./services/markerService";
import { Place } from "./dtos/place";
import { Marker } from "./models/marker";

// Start writing functions
// https://firebase.google.com/docs/functions/typescript

firebase.initializeApp();

export const helloWorld = onRequest((request, response) => {
  logger.info("Hello logs!", { structuredData: true });
  response.send("Hello from Firebase!");
});

export const importPlaces = onRequest(async (request, response) => {
  logger.info("Recevid request to insert data", { structuredData: true });
  const categories = await categoryService.getAll();

  const datas = request.body as Place[];
  const markers = [];
  for (const place of datas) {
    let category = categories.find((c) => c.name === place.category.name);
    if (!category) {
      category = await categoryService.create(place.category.name);
      categories.push(category);
    }
    markers.push({
      id: place.id?.toString(),
      categoryId: category.id,
      title: place.name,
      description: place.description,
      latitude: place.location.latitude,
      longitude: place.location.longitude,
      verifiedAt: new Date(place.date_verified),
    } as Marker);
  }

  await markerService.insertUpdateMarkers(markers);
  response.send(markers);
});

export const getAllIds = onRequest(async (request, response) => {
  logger.info("Recevid request to get all ids", { structuredData: true });

  const result = await markerService.getAllIds();
  response.status(200).send(result);
});

export const importCategories = onRequest(async (request, response) => {
  logger.info("Recevid request to insert data", { structuredData: true });

  const datas = request.body as Category[];
  const result = await categoryService.insertUpdateCategories(datas);
  response.status(200).send(result);
});
