const express = require('express');
var db = require("./regDatabase");
const bodyParser = require("body-parser");
const bcrypt = require('bcryptjs');

const app = express()

app.use(express.static('./views'));
app.use(express.json());
app.set('view engine', 'ejs');
app.use(bodyParser.urlencoded({ extended: true }));


app.get('/home', (req, res) => {
    res.status(200).render('home');
});

app.get('/registration', (req, res) => {
    res.status(200).render('registration', { registrationError: "" });
});

app.get('/login', (req, res) => {
    res.status(200).render('login', { loginError: "" });
});

app.get('/guests/login', (req, res) => {
    res.status(200).render('guestlogin');
});
app.get('/guests/logout', (req, res) => {
    res.status(200).render('guestlogout', { guestlogoutError: "" });
});

app.get('/logout', (req, res) => {
    res.status(200).render('logout', { logoutError: "" });
});

app.post('/registration', (req, res) => {
    try {
        const { regfullname, regemail, regdepartment, regworkerid, regpassword } = req.body; //Gets the  values of the user input

        db.query("SELECT email,workerId FROM workerReg where email = '" + regemail + "' OR workerId = '" + regworkerid + "'", async (err, result) => {

            if (err) throw err;

            if (result.length != 0) {
                res.status(401).render('registration', { registrationError: "The Email or ID is already in use" })
            }

            if (result.length === 0) {
                const hashPassword = await bcrypt.hash(regpassword, 10)  // Hashes the user password
                let sql = `INSERT INTO workerReg (name, email, department,workerId,password) VALUES ("${regfullname}", "${regemail}", "${regdepartment}", "${regworkerid}", "${hashPassword}" )`;

                db.query(sql, (err, data) => {
                    if (err) throw err;
                    res.status(401).render('login', { loginError: "" })
                    console.log("User data is inserted successfully ");
                });

            }

        });

    }

    catch (err) {

        console.log("Something went wrong");
    }
});

app.post('/login', (req, res) => {
    const { loginworkerId, loginpassword } = req.body;
    db.query("SELECT workerId,password FROM workerReg where workerId = '" + loginworkerId + "' ", async (err, result) => {

        if (result.length === 0) {
            res.status(401).render('login', { loginError: "Wrong Worker ID entered" });
        }

        if (result.length != 0) {
            Object.keys(result).forEach(async (key) => {
                let passwordRow = result[key];
                const regHashedPassword = (passwordRow.password); //Get the hashed password that is in the database
                const isValid = await bcrypt.compare(loginpassword, regHashedPassword); //You compare the password entered and the hashed password that is stored in the databae. NB you should not hash the new password again.

                if (isValid) {
                    function getDateTime() {
                        const todaytime = new Date().toLocaleTimeString();
                        const todaydate = new Date().toLocaleDateString();

                        db.query("SELECT workerId,name,department FROM workerReg where workerId = '" + loginworkerId + "' ", (err, result) => {

                            Object.keys(result).forEach(async (key) => {
                                let data = result[key];
                                const workerName = (data.name);
                                const workerDepartment = (data.department);
                                const workerIdNumber = (data.workerId);

                                db.query(`INSERT INTO logindata (name,department,workerId,date,time) VALUES ("${workerName}", "${workerDepartment}", "${workerIdNumber}", "${todaydate}", "${todaytime}" )`)

                                res.status(200).send(`${workerName} you have come to work at ${todaytime} Have a lovely day Ahead`);
                            });
                        });
                    }
                    getDateTime();
                }
                else {
                    res.status(401).render('login', { loginError: "You have entered the wrong Password" });
                }
            })
        }
    })
});

app.post('/guests/login', (req, res) => {

    const { guestsname, guestsid } = req.body
    const todaytime = new Date().toLocaleTimeString();
    const todaydate = new Date().toLocaleDateString();
    let exitDate = "";
    let exitTime = "";

    db.query(`INSERT INTO guestsdata (name, guestId, entryDate, entryTime,exitDate, exitTime) VALUES ("${guestsname}","${guestsid}","${todaydate}","${todaytime}", "${exitDate}","${exitTime}")`);
    res.status(200).send(`Welcome ${guestsname} to our Company...We hope you Enjoy`)

});

app.post('/guests/logout', (req, res) => {
    const { guestsid } = req.body
    const todaytime = new Date().toLocaleTimeString();
    const todaydate = new Date().toLocaleDateString();
    let exitDate = "";
    let exitTime = "";

    db.query("SELECT exitDate,exitTime,guestId FROM guestsdata WHERE guestId = '" + guestsid + "'  ", (err, result) => {
        console.log(result);

        if (result.length == 0){
            res.status(401).render('guestlogout', { guestlogoutError: "The Id you have entered is invalid" })
        }

        Object.keys(result).forEach(async (key) => {
            let data = result[key];
            const emptyDate = (data.exitDate);
            const emptyTime = (data.exitTime);
            const guestIdLogin = (data.guestId);

            if (guestIdLogin === "") {
                res.status(401).render('guestlogout', { guestlogoutError: "You must have visited In to be logged out" })
            }
            if (emptyDate === "") {
                db.query(`UPDATE guestsdata SET exitDate = "${todaydate}" , exitTime = "${todaytime}" WHERE guestId = "${guestsid}" `);
                res.status(200).send(`Thank for visiting our Company`)
            }
            if (emptyDate != "") {
                res.status(401).render('guestlogout', { guestlogoutError: "Please Confirm that you are Entering and not Exiting" })
            }
        });
    });
});

app.post('/logout', (req, res) => {
    const { logoutworkerId, logoutpassword } = req.body;

    db.query("SELECT workerId,password FROM workerReg where workerId = '" + logoutworkerId + "' ", async (err, result) => {

        if (result.length != 0) {

            Object.keys(result).forEach(async (key) => {
                let passwordRow = result[key];
                const regHashedPassword = (passwordRow.password); //Get the hashed password tha is in the database
                const isValid = await bcrypt.compare(logoutpassword, regHashedPassword); //You compare the password entered and the hashed password that is stored in the databae. NB you should not hash the new password again.

                if (isValid) {

                    function logOut() {
                        const todaytime = new Date().toLocaleTimeString();
                        const todaydate = new Date().toLocaleDateString();

                        db.query("SELECT workerId,name,department FROM workerReg where workerId = '" + logoutworkerId + "' ", (err, result) => {

                            Object.keys(result).forEach(async (key) => {
                                let data = result[key];
                                const workerName = (data.name);
                                const workerDepartment = (data.department);
                                const workerIdNumber = (data.workerId);

                                db.query(`INSERT INTO logoutdata (name,department,workerId,date,time) VALUES ("${workerName}", "${workerDepartment}", "${workerIdNumber}", "${todaydate}", "${todaytime}" )`)

                                res.status(200).send(`Thank you ${workerName} for coming you logged out at ${todaytime}. We hope to see you tommorow`)
                            });
                        });
                    }

                    logOut();

                }

                else {
                    res.status(401).render('logout', { logoutError: "You have entered the wrong Password" });

                }
            })
        }

        if (result.length === 0) {

            res.status(401).render('logout', { logoutError: "Wrong Worker ID entered" });
        }
    })
});

app.listen('5600', () => {
    console.log("listening on port 5600");
})