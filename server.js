const express = require('express');
const http = require('http');
const path = require('path');
const app = express();
const port = process.env.PORT || 3000;
const mysql = require('mysql');
const host = 'localhost';
const user = 'root';
const password = '1234';
const database = 'UrlGen';
const cors = require('cors');
const bodyParser = require('body-parser');



const connection = mysql.createConnection({host, user, password, database});

connection.connect(function(err) {
    if (err) {
        console.error('error connecting: ' + err.stack);
        return;
    }
    console.log('database connected as id ' + connection.threadId);
});

const applicationDir = path.join(__dirname, 'dist', 'url-generator');

// parse application/x-www-form-urlencoded
app.use(bodyParser.urlencoded({ extended: false }))

// parse application/json
app.use(bodyParser.json());

app.use(express.static(applicationDir));
app.use(cors())

app.get('/', (req, res) => res.sendFile(path.join(applicationDir + '/index.html')));


app.post('/getUrl', (req, res) => {

    const query = mysql.format( 'CALL UrlGen.saveUrl(?)', [req.body.url] );

	connection.query(query, function (err, result){
        if (err) {
            return res.status(500).json({status: false, message: 'Internal Server Error'})
        }
        return res.status(200).json({status: true, message: 'Url Generated Successfully', result: result[0]})
    })
});


const server = http.createServer(app);
server.listen(port, () => console.log(`App running on port : ${port}`));
