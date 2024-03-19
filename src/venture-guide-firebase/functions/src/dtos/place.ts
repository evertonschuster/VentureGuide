export interface Place {
    id: null | string;
    name: string;
    date_verified: string;
    description: string;
    location: {
        latitude: number;
        longitude: number;
    };
    category: {
        name: string;
    };
}
