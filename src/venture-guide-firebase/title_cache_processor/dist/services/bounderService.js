"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || function (mod) {
    if (mod && mod.__esModule) return mod;
    var result = {};
    if (mod != null) for (var k in mod) if (k !== "default" && Object.prototype.hasOwnProperty.call(mod, k)) __createBinding(result, mod, k);
    __setModuleDefault(result, mod);
    return result;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.getBounderTitle = void 0;
const firebase = __importStar(require("firebase-admin"));
const getBounderTitle = async () => {
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
};
exports.getBounderTitle = getBounderTitle;
