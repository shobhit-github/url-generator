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
const unirest = require("unirest");
const apiKey = "aa61eced93msh98c941b19e19ec8p17c0e3jsn0bb9aa240a27";


const connection = mysql.createConnection({host, user, password, database});

connection.connect(function (err) {
    if (err) {
        console.error('error connecting: ' + err.stack);
        return;
    }
    console.log('database connected as id ' + connection.threadId);
});

const applicationDir = path.join(__dirname, 'dist', 'url-generator');

// parse application/x-www-form-urlencoded
app.use(bodyParser.urlencoded({extended: false}))

// parse application/json
app.use(bodyParser.json());

app.use(express.static(applicationDir));
app.use(cors())

app.get('/', (req, res) => res.sendFile(path.join(applicationDir + '/index.html')));


app.post('/getUrl', (req, res) => {

    const query = mysql.format('CALL UrlGen.saveUrl(?)', [req.body.url]);

    connection.query(query, function (err, result) {
        if (err) {
            return res.status(500).json({status: false, message: 'Internal Server Error'})
        }

        executeTraffic( result[0][0], function (err, response) {
            if (err) {
                return res.status(500).json({status: false, message: 'Unable to read URL: ' + result[0][0].actualPath, error: err})
            }

            return res.status(200).json({status: true, message: 'Url Generated Successfully', result: response})
        } )

    })
});


const executeTraffic = (urlObject, callback) => {

    console.log(urlObject)
    const webhookReq = unirest("GET", "https://similarweb2.p.rapidapi.com/trafficoverview");
    webhookReq.headers({ "x-rapidapi-host": "similarweb2.p.rapidapi.com", "x-rapidapi-key": apiKey, "useQueryString": true });
    webhookReq.query({"website": encodeURI(urlObject.actualPath)});

    let countryArr = [];

    webhookReq.end(function (result) {

        if (result.error) {
            return callback( result.error, false);
        }

        const apiResponse = result.body;

        if (apiResponse.trafficShareByCountry.length) {
            countryArr = apiResponse.trafficShareByCountry.map(va => Object.keys(va)).map( k => k[0]);
        }
        console.log(countryArr)
        const query = mysql.format('CALL UrlGen.saveAnalytics(?,?,?,?)', [urlObject.id, apiResponse.engagement.totalVisits, countryArr.join(), JSON.stringify(apiResponse) ]);

        connection.query(query, function (err, okResponse) {
            console.log(err)
            if (err) {
                return callback( err, false);
            }

            return  callback(false, okResponse[0])

        })
    });
}

app.get('/stats', (req, res) => {

    connection.query('CALL UrlGen.getAnalytics()', function (err, okResponse) {
        if (err) {
            return res.status(500).json({status: false, message: 'Error Inter Issue'})
        }

        return res.status(200).json({status: true, message: 'data Retrieved', result: okResponse[0]})

    })
});


const server = http.createServer(app);
server.listen(port, () => console.log(`App running on port : ${port}`));
