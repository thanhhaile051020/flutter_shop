const express = require("express");
const route = express();
const paypal = require("paypal-rest-sdk");
const queryString = require("query-string");


paypal.configure({
    'mode': 'sandbox',
    'client_id': 'AauCcMPIEOIa7MXUNgq8A6ZmHl187RhP-vMFx9reuus9Zr0kC3eHKISh_CO3u2W284A7e-EEpJyzdNvX',
    'client_secret': 'ED0gHsKQ0nrZxkAVZpZrMuHi8nNVuBYnnP63cfXyYKm6qOa3_NqMikBrpba71emyn8N3NAa_-JWtNNsk'
});

route.get('/createpaypalpayment', async (req, res) => {
    const amount = req.query.amount;
    const currency = req.query.currency.toUpperCase();

    var create_payment_json = {
        "intent": "sale",
        "payer": {
            "payment_method": "paypal"
        },
        /// Return url which will be executed once the intent is created.
        /// "https://us-central1-paypal.cloudfunctions.net/paypalTestPaymentExecute",
        /// 
        "redirect_urls": {
            "return_url": `http://10.0.2.2:3000/execute?amount=${amount}&currency=${currency}`,
            "cancel_url": "http://cancel.url"
        },
        "transactions": [{
            "item_list": {
                "items": [{
                    "name": "item",
                    "sku": "item",
                    "price": amount,
                    "currency": currency,
                    "quantity": 1
                }]
            },
            "amount": {
                "currency": currency,
                "total": amount
            },
            "description": "This is the payment description."
        }]
    };

    paypal.payment.create(create_payment_json, function (error, payment) {
        if (error) {
            console.log(error);
            throw error;
        } else {
            console.log('create payment response');
            console.log(payment);
            for (var index = 0; index < payment.links.length; index++) {
                if (payment.links[index].rel === 'approval_url') {
                    res.redirect(payment.links[index].href);
                }
            }
        }
    });
});

route.get('/execute', async (req, res) => {
    const amount = req.query.amount;
    const currency = req.query.currency.toUpperCase();

    var execute_payment_json = {
        "payer_id": req.query.PayerID,
        "transactions": [{
            "amount": {
                "currency": currency,
                "total": amount
            }
        }]
    };
    const paymentId = req.query.paymentId;
    paypal.payment.execute(paymentId, execute_payment_json, function (error, payment) {
        if (error) {
            console.log(error);
            throw error;
        } else {
            console.log(JSON.stringify(payment));
            res.redirect("http://return_url/?status=success&id=" + payment.id + "&state=" + payment.state);
        }
    });
});


module.exports = route;