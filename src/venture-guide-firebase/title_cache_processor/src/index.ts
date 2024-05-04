import * as admin from 'firebase-admin';
import { getBounderTitle } from './services/bounderService';
import { getPlaces } from './services/markerService';
import { saveTitleMarkers } from './services/titleMarkersService';

// Substitua pelo caminho do seu arquivo de chave do Firebase
const serviceAccount = require('./venture-guide-firebase-adminsdk-zsdpa-dda14fa5b5.json');

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount)
});

console.log("Teste");

getBounderTitle()
    .then(async (result) => {
        console.log(result);

        for (let x = result.titleXAsc; x <= result.titleXDesc; x++) {
            for (let y = result.titleYAsc; y <= result.titleYDesc; y++) {
                console.log(`(${x}, ${y})`);                
                
                var markers = await getPlaces(x, y);

                if (markers.length === 0) {
                    console.log(`No markers found for (${x}, ${y})`);
                    continue;
                }

                console.log(`Found ${markers.length} markers for (${x}, ${y})`);
                await saveTitleMarkers(x, y, markers);
            }
        }
    });


