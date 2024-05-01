import * as firebase from "firebase-admin";
import * as tileService from "./tileService";
import { Marker } from "../models/marker";
import { Filter } from "firebase-admin/firestore";

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

export const getNearbyPlaces = async (latitude: number, longitude: number) => {
    const latLog = {
        latitude: latitude,
        longitude: longitude,
    }
    const title = tileService.latLngToTile(latLog);

    const filters = Filter.and(
        Filter.where("titleX", ">=", title.x - 1),
        Filter.where("titleX", "<=", title.x + 1),
        Filter.where("titleY", ">=", title.y - 1),
        Filter.where("titleY", "<=", title.y + 1),
    );

    const markersRef = firebase.firestore().collection("markers");
    const markers = await markersRef
        .where(filters)
        .get()

    return markers.docs.map((doc) => doc.data() as Marker);
}

export const getPlaces = async (titleX: number, titleY: number) => {
    const filters = Filter.and(
        Filter.where("titleX", "==", titleX),
        Filter.where("titleY", "==", titleY)
    );

    const markersRef = firebase.firestore().collection("markers");
    const markers = await markersRef
        .where(filters)
        .get()

    return markers.docs.map((doc) => doc.data() as Marker);
}
