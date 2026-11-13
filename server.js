/**
 * Weekmotion Real-Time WebSocket Event Broker
 * High-concurrency event dispatcher for live comments, notifications, and telemetry
 */
const http = require('http');

const PORT = process.env.WS_PORT || 8000;

const server = http.createServer((req, res) => {
    if (req.url === '/health' || req.url === '/ping') {
        res.writeHead(200, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ status: 'ok', service: 'weekmotion-broker', uptime: process.uptime() }));
        return;
    }
    res.writeHead(200, { 'Content-Type': 'text/plain' });
    res.end('Weekmotion Real-Time Gateway Active\n');
});

server.listen(PORT, '0.0.0.0', () => {
    console.log(`[Weekmotion Broker] Real-time engine listening on port ${PORT}`);
});
