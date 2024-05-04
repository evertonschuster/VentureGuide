import * as firebase from "firebase-admin";
import * as tileService from "./tileService";
import { Marker } from "../models/marker";
import { TitleMarkers } from "../models/titleMarkers";
import { Filter } from "firebase-admin/firestore";

export const getPlaces = async (titleX: number, titleY: number) => {
    const titleMarkersRef = firebase.firestore().collection("titleMarkers");
    const titleMarkers = await titleMarkersRef
        .doc(`${titleX}-${titleY}`)
        .get()

    const title = titleMarkers?.data() as TitleMarkers;

    return (title?.markers as Marker[]) ?? [];
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

    const markersRef = firebase.firestore().collection("titleMarkers");
    const markers = await markersRef
        .where(filters)
        .get()

    return markers.docs
        ?.map((doc) => doc.data() as TitleMarkers)
        ?.flatMap((e) => (e.markers as Marker[]) ?? []) ?? [];
}
