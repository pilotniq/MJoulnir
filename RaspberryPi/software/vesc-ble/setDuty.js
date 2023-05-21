const vesc = require("./index.js");

async function delay(seconds)
{
        return new Promise( resolve => setTimeout( resolve, seconds * 1000 ) );
}

duty = parseFloat(process.argv[2]);
if( isNaN(duty)) {
    console.log("Bad duty passed in");
    return(-1);
}
console.log("Got duty " + duty);

v = new vesc.VESC();

async function f()
{
    await v.ble_connect();

    await v.sendSetDuty(duty);
    await delay(2);
    await v.sendSetDuty(0);
}

f();
