Enable Paystack payments for the OFA site

1) Add Paystack keys to `index.html` and server env

 - In `index.html` replace the meta key: <meta name="paystack-public-key" content="pk_test_REPLACE_ME"> with your Paystack public test key (pk_test_xxx). For production use pk_live_xxx.

 - On your server, set `PAYSTACK_SECRET_KEY=sk_test_xxx` (or your live secret in production).

2) Run verification server (optional but recommended)

 - Install server deps: npm install express node-fetch body-parser dotenv
 - Start: node server/verify.js
 - Use the /verify-paystack endpoint to verify transaction references received in the client-side callback.

3) Client-side flow

 - When a payment completes Paystack returns a reference in the callback function. POST { reference } to /verify-paystack to confirm status before marking donation as final.

4) Security

 - Never store secret keys in the frontend or commit them to source control.
 - Always verify transactions server-side using your secret key before granting access or issuing receipts.

5) Testing

 - Use Paystack test keys and test cards (see Paystack docs) to simulate a payment flow.
