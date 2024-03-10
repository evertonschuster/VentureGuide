import { Category } from "../models/category";
import * as firebase from "firebase-admin";

export const insertUpdateCategories = async (categories: Category[]) => {
    const batch = firebase.firestore().batch();
    const categoriesRef = firebase.firestore().collection("categories");

    categories.forEach((category) => {
        const doc = categoriesRef.doc(category.id);
        batch.set(doc, category);
    });
    await batch.commit();

    return (await categoriesRef.orderBy("name").get())
        .docs.map((doc) => doc.data() as Category);
}
