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
export const getAll = async (): Promise<Category[]> => {
    return await firebase.firestore().collection("categories")
        .orderBy("name")
        .get()
        .then((querySnapshot) => {
            return querySnapshot.docs.map((doc) => doc.data() as Category);
        });
}

export const create = async (name: string): Promise<Category> => {
    const categoriesRef = firebase.firestore().collection("categories");
    const category = {
        id: categoriesRef.doc().id,
        name: name,
    } as Category;
    await categoriesRef.doc(category.id).set(category);
    return category;
}

