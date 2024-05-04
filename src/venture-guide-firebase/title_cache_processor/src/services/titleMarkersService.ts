import * as firebase from "firebase-admin";
import { Marker } from "../models/marker";

export const saveTitleMarkers = async (titleX: number, titleY: number, markers: Marker[]) => {
    const titleMarkersRef = firebase.firestore().collection("titleMarkers");

    await titleMarkersRef.doc(`${titleX}-${titleY}`)
        .set({
            id: `${titleX}-${titleY}`,
            titleX,
            titleY,
            markers,
            updatedAt: new Date()
        });
}