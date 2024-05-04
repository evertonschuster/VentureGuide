import * as firebase from "firebase-admin";

export const getBounderTitle = async () => {
    const markersRef = firebase.firestore().collection("markers");

    const markerXDesc = await markersRef
        .orderBy("titleX", "desc")
        .limit(1)
        .get();

    const markerYDesc = await markersRef
        .orderBy("titleY", "desc")
        .limit(1)
        .get();

    const markerXAsc = await markersRef
        .orderBy("titleX", "asc")
        .limit(1)
        .get();

    const markerYAsc = await markersRef
        .orderBy("titleY", "asc")
        .limit(1)
        .get();


    return {
        titleXDesc: markerXDesc.docs[0].data().titleX,
        titleYDesc: markerYDesc.docs[0].data().titleY,
        titleXAsc: markerXAsc.docs[0].data().titleX,
        titleYAsc: markerYAsc.docs[0].data().titleY,
    };
    
}