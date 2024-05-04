import * as firebase from "firebase-admin";
import { Filter } from "firebase-admin/firestore";
import { Marker } from "../models/marker";

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
