export interface LatLng {
    latitude: number;
    longitude: number;
}

export interface Point {
    x: number;
    y: number;
}

const zoom = 7;
export const latLngToTile = (latLng: LatLng): Point => {
    const lat = latLng.latitude;
    const lng = latLng.longitude;

    // Converter coordenadas para radianos
    const latRad = lat * Math.PI / 180;

    // Cálculo da projeção de Mercator
    const mercN = Math.log(Math.tan((Math.PI / 4) + (latRad / 2)));

    // Calculando as coordenadas do tile
    const x = Math.floor((lng + 180) / 360 * Math.pow(2, zoom));
    const y = Math.floor((1 - mercN / Math.PI) / 2 * Math.pow(2, zoom));

    return { x, y };
}
