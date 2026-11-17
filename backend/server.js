// Backend minimal du jalon J1 : sert les données fictives en lecture seule.
// Aucune dépendance : il suffit de Node.js (npm start).
const http = require('http');
const fs = require('fs');
const path = require('path');

const PORT = process.env.PORT || 3000;
const plages = JSON.parse(
  fs.readFileSync(path.join(__dirname, 'data', 'plages.json'), 'utf8')
);

function repondre(res, code, corps) {
  res.writeHead(code, {
    'Content-Type': 'application/json; charset=utf-8',
    'Access-Control-Allow-Origin': '*',
  });
  res.end(JSON.stringify(corps));
}

const serveur = http.createServer((req, res) => {
  const url = new URL(req.url, 'http://localhost');

  if (req.method !== 'GET') {
    return repondre(res, 405, { erreur: 'Méthode non autorisée' });
  }

  // GET /api/plages?region=Bizerte&q=corniche
  if (url.pathname === '/api/plages') {
    const region = (url.searchParams.get('region') || '').toLowerCase();
    const q = (url.searchParams.get('q') || '').toLowerCase();
    const resultat = plages.filter(
      (p) =>
        (region === '' || p.gouvernorat.toLowerCase() === region) &&
        p.nom.toLowerCase().includes(q)
    );
    return repondre(res, 200, resultat);
  }

  // GET /api/plages/:id
  const m = url.pathname.match(/^\/api\/plages\/([^/]+)$/);
  if (m) {
    const plage = plages.find((p) => p.id === m[1]);
    return plage
      ? repondre(res, 200, plage)
      : repondre(res, 404, { erreur: 'Plage introuvable' });
  }

  repondre(res, 404, { erreur: 'Route inconnue' });
});

serveur.listen(PORT, '0.0.0.0', () => {
  console.log(`Chatt backend : http://localhost:${PORT}/api/plages`);
});
