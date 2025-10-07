# Old Francans' Association (OFA) — Vite + React + Tailwind Scaffold

This repository is a starter scaffold for the Old Francans' Association single-page application (SPA) built with React and Tailwind CSS.

## What is included
- Vite-based React project
- TailwindCSS configured (dark mode via `class`)
- Basic component structure: Header, Hero, QuickTiles, Footer
- Client-side router implemented without external libraries
- Placeholder pages for all OFA sections and sub-items

## Windows (PowerShell) setup

Open PowerShell in the project root and run:

```powershell
npm install
npm run dev
```

Then open the printed localhost URL in your browser.

## Next steps
- Replace placeholder images with real OFA photos (retina-optimized)
- Flesh out each inner page's content
- Implement server-side search or integrate a members directory backend (optional)
- Add unit tests and accessibility audits

## Notes
- Tailwind's `dark` mode uses the `class` strategy. Toggle stored in `localStorage`.
- Navigation uses the History API; no external router is included.

