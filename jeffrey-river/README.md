# Jeffrey River — Official Website

The source for [www.jeffreyriver.com](https://www.jeffreyriver.com) — the home of Jeffrey River, an acoustic folk singer-songwriter from Sandpoint, Idaho.

---

## What's Here

```
jeffrey-river/
├── index.html        # Home page
├── music.html        # Music page (players for upcoming releases)
├── about.html        # About + bio + press/EPK
├── gigs.html         # Gigs calendar + booking form
├── merch.html        # Merch shop (coming soon)
├── css/styles.css    # All styling (nature/pastel palette)
├── js/main.js        # Mobile nav, play toggle, misc
├── images/           # (placeholder — add photos here)
└── CNAME             # Tells GitHub Pages to use www.jeffreyriver.com
```

## Design System

Colors — edit in `css/styles.css` under `:root`:

- `--sage` — misty sage green (primary accent)
- `--river` — medium watercolor blue
- `--leather` — warm leather brown (CTAs)
- `--cream` / `--parchment` — warm off-white backgrounds
- `--charcoal` — body text

Typography:
- **Playfair Display** — headings (vintage serif feel)
- **Inter** — body text
- **Caveat** — handwritten accents (eyebrows, taglines)

---

## How to Deploy

This site auto-deploys to GitHub Pages via `.github/workflows/deploy-jeffrey-river.yml` whenever changes in `jeffrey-river/` are pushed to `main`.

### First-Time Setup (one time)

1. Push this branch and merge to `main`
2. Go to the repo on GitHub → **Settings → Pages**
3. Under **Source**, select **GitHub Actions**
4. Under **Custom domain**, enter `www.jeffreyriver.com` → Save
5. Check **Enforce HTTPS** once the certificate provisions (can take up to 24 hrs)

### DNS (done at your registrar — Cloudflare)

These records should already be configured:

**A records (`@`)** — all 4 pointing to GitHub:
- `185.199.108.153`
- `185.199.109.153`
- `185.199.110.153`
- `185.199.111.153`

**CNAME (`www`)** → `jbickish7464.github.io`

Set all to **DNS only** (gray cloud in Cloudflare) — not proxied.

---

## How to Update

### Add a show to the Gigs page

Open `gigs.html`, find the commented-out `<!-- Template for adding a show -->` block, copy the `<ul class="gigs">` structure, and fill in your details. Remove the empty-state `.gigs--empty` div when you have shows.

### Swap in real photos

Drop photos into the `images/` folder, then replace the placeholder divs like `<div class="about__image">...</div>` with `<img src="images/your-photo.jpg" alt="..." />`.

### Update the bio

Edit `about.html` — the main bio is in the first `.section` after the page header, and pre-written short bios (50 / 150 word versions) follow.

### Connect MailerLite

Each page has a `<form class="signup__form">` — replace the empty `action=""` with your MailerLite embed form URL. Full instructions in the session record.

### Connect the booking form

In `gigs.html`, the booking form uses Formspree as a placeholder. Sign up at [formspree.io](https://formspree.io) (free), create a form, and replace `YOUR_FORM_ID` in the form's `action` attribute.

---

## Domain

Registered at **Cloudflare**. DNS points to GitHub Pages. HTTPS handled by GitHub automatically.
