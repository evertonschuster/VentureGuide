export interface Place {
    id: number;
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
