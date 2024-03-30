import * as firebase from "firebase-admin";
import * as tileService from "./tileService";
import { Marker } from "../models/marker";

export const insertUpdateMarkers = async (markers: Marker[]) => {
    const batch = firebase.firestore().batch();
    const markersRef = firebase.firestore().collection("markers");

    markers.forEach((marker) => {
        const doc = markersRef.doc(marker.id);
        const latLog = {
            latitude: marker.latitude,
            longitude: marker.longitude,
        }
        const title = tileService.latLngToTile(latLog);
        marker.titleX = title.x;
        marker.titleY = title.y;

        batch.set(doc, marker);
    });
    await batch.commit();

    return (await markersRef.orderBy("title").get())
        .docs.map((doc) => doc.data() as Marker);
}

export const getAllIds= () => {
    return firebase.firestore().collection("markers").get()
        .then((snapshot) => {
            return snapshot.docs.map((doc) => doc.id);
        });
}
