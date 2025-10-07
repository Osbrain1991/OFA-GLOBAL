OFA Site - Production build & run

Build frontend (local):

- Install dependencies: `npm ci`
- Build frontend: `npm run build:prod`

Run server locally (serves built frontend if present):

- Start server: `npm run start:prod`
- The server listens on port 5178 by default. Set `PORT` env var to change.

Run with Docker (recommended for reproducible deploys):

- Build image: `npm run docker-build` or `docker build -t ofalumni:latest .`
- Run container: `docker run -p 5178:5178 -e ADMIN_EMAIL=you@host -e ADMIN_PASSWORD=2017 -v $(pwd)/server/data:/app/server/data -v $(pwd)/server/uploads:/app/server/uploads ofalumni:latest`

Notes:
- Set `ADMIN_EMAIL`, `ADMIN_PASSWORD`, and `ADMIN_SECRET` in production environment for admin management.
- Consider replacing file-based persistence in `server/data` with a proper DB before high-traffic production use.
- Move uploads to cloud storage (S3, Firebase Storage) for durability.

Firebase (optional):

You can configure the server to upload assets to Firebase Storage instead of local disk. Provide:

	- `FIREBASE_BUCKET` — the Storage bucket name (e.g. `my-project.appspot.com`)
	- `FIREBASE_SERVICE_ACCOUNT_PATH` — path to a service account JSON file inside the container, or
	- `FIREBASE_SERVICE_ACCOUNT` — JSON string of the service account credentials (useful for CI secrets)

Example environment variables when running the container:

```powershell
docker run -p 5178:5178 -e FIREBASE_BUCKET=my-bucket.appspot.com -e FIREBASE_SERVICE_ACCOUNT_PATH=/run/secrets/firebase.json -v $(pwd)/server/data:/app/server/data -v $(pwd)/server/uploads:/app/server/uploads ofalumni:latest
```

The server will attempt to initialize Firebase Storage if both the bucket and service account are provided. If initialization fails, it falls back to saving uploads to `server/uploads`.

CI notes (GitHub Actions):

Store the following secrets in your repository settings if you want CI to run against Firebase-backed uploads:

	- `FIREBASE_BUCKET` (your bucket name)
	- `FIREBASE_SERVICE_ACCOUNT` (the full JSON contents of the service account)
	- `ADMIN_EMAIL` and `ADMIN_PASSWORD` for admin login used by the E2E smoke test

The repository includes a sample workflow at `.github/workflows/ci.yml` that shows how to write the `FIREBASE_SERVICE_ACCOUNT` secret to a file and start the server before running `scripts/test-e2e.cjs`.
