const express = require('express');
const path = require('path');
const app = express();

// Serve static files from the "public" directory/home/tanmayee_v/fpi/manufacturer/src/manufacturer_assets
app.use('/src/manufacturer_assets/src', express.static(path.join(__dirname, 'src/manufacturer_assets/src')));

app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'src/manufacturer_assets/src/index.html'));
});

app.get('/manf', (req, res) => {
  res.sendFile(path.join(__dirname, 'src/manufacturer_assets/src/manf.html'));
});

app.listen(3000, () => {
  console.log('Server is running on http://localhost:3000');
});



// const http = require('http');
// const fs = require('fs');
// const path = require('path');

// http.createServer(function (request, response) {
//     console.log('request ', request.url);

//     let filePath = '.' + request.url;
//     if (filePath == './') {
//         filePath = '/home/tanmayee_v/fpi/manufacturer/src/manufacturer_assets/src/index.html';
//     }
//     const mimeTypes = {
//         '.js': 'application/javascript',
//         '.html': 'text/html',
//         // add more MIME types depending on the file types you'll be serving
//       };

//     const extname = String(path.extname(filePath)).toLowerCase();
//     let contentType = 'text/html';

//     fs.readFile(filePath, function(error, content) {
//         if (error) {
//             console.log('error', error);
//             // handle error, for example send 404 if file not found
//         }
//         else {
//             response.writeHead(200, { 'Content-Type': contentType });
//             response.end(content, 'utf-8');
//         }
//     });

// }).listen(8125);
// console.log('Server running at http://127.0.0.1:8125/');