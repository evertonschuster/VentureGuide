import { Marker } from "./marker";

export interface TitleMarkers {
    id: string;
    titleX: number;
    titleY: number;

    markers: Marker[];

    updatedAt: Date;
}
