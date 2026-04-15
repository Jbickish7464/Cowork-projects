# GitHub Auto-Push Setup Guide
### Bush Legacy Builders — Claude Cowork Projects
**Last Updated:** 2026-04-15

---

## What This Does

Every time Claude creates or updates files in a project folder, it automatically pushes those files to GitHub. This gives you:
- Version history of all project documents
- Cloud backup of everything Claude creates
- A single repo (`Cowork-projects`) with one folder per job

---

## How It Was Set Up (Step-by-Step)

### Step 1 — Create the GitHub Repository
1. Go to [github.com/new](https://github.com/new)
2. Name it: `Cowork-projects`
3. Set visibility: **Private** (recommended for client files)
4. Initialize with a README
5. Click **Create repository**

> Repo URL: `https://github.com/Jbickish7464/Cowork-projects`

---

### Step 2 — Generate a Personal Access Token (PAT)
This is the password Claude uses to push files without you logging in.

1. Go to GitHub → Settings → Developer settings → Personal access tokens → **Tokens (classic)**
2. Click **Generate new token (classic)**
3. Name it: `Claude Cowork Push`
4. Set expiration: **No expiration** (or 1 year — your call)
5. Check the scope: ✅ **repo** (full control of private repositories)
6. Click **Generate token**
7. **Copy the token immediately** — GitHub only shows it once

> Token format: `ghp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx`

---

### Step 3 — Create the `push_to_github.bat` File
Place this file in each project folder (e.g., `C:\Users\jeffr\OneDrive\Documents\Claude\Projects\{ProjectName}\`).

See the template: `push_to_github_TEMPLATE.bat` in this folder.

Key variables to update per project:
| Variable | Example |
|---|---|
| `GH_TOKEN` | Your PAT from Step 2 |
| `GH_USER` | `Jbickish7464` |
| `REPO` | `Cowork-projects` |
| `BRANCH` | `main` |
| `PROJECT_PATH` | `bush-legacy/beeksma` |

---

### Step 4 — Tell Claude the Rule
Claude now has a saved memory rule:
> *"After creating or updating any project files, always push them to GitHub as the final step."*

This means Claude will automatically run the git push at the end of every task — you don't have to ask.

---

### Step 5 — Folder Structure in GitHub

```
Cowork-projects/
└── bush-legacy/
    ├── beeksma/          ← Current project
    │   ├── README.md
    │   ├── Beeksma Procurement Selection Status.xlsx
    │   └── push_to_github.bat
    ├── next-project/
    └── ...
```

To add a new project:
1. Create a new folder: `C:\Users\jeffr\OneDrive\Documents\Claude\Projects\{NewProject}\`
2. Copy `push_to_github_TEMPLATE.bat` into it
3. Update the `PROJECT_PATH` variable (e.g., `bush-legacy/newproject`)
4. Tell Claude: *"This project should push to bush-legacy/newproject"*

---

## How Claude Pushes Files (Under the Hood)

When Claude runs the push, it does the following from its Linux workspace:

```bash
# 1. Clone the repo into a temp directory
git clone https://{TOKEN}@github.com/{USER}/{REPO}.git /tmp/push-work

# 2. Copy new/updated files into the project subfolder
cp {workspace_files} /tmp/push-work/bush-legacy/{project}/

# 3. Commit with a dated message
git config user.email "jeffrey@bushlegacybuilders.com"
git config user.name "Jeffrey Bickish"
git add bush-legacy/{project}/
git commit -m "Update {project} docs - 2026-04-15"

# 4. Push back to GitHub
git push https://{TOKEN}@github.com/{USER}/{REPO}.git main
```

No local git installation required on your machine — Claude handles it all.

---

## Token Renewal

GitHub PATs expire if you set an expiration date. When the push fails:
1. Generate a new token (Step 2 above)
2. Update `GH_TOKEN=` in the `push_to_github.bat` file in your project folder
3. Tell Claude: *"I updated the GitHub token"*

---

## Troubleshooting

| Issue | Fix |
|---|---|
| `Push failed — repo not found` | Check that the repo exists at github.com and the name matches exactly |
| `Authentication failed` | Token may be expired — generate a new one |
| `Nothing to commit` | Files haven't changed since last push — that's fine |
| `Merge conflict` | Shouldn't happen since Claude always pulls before pushing, but if so: delete `/tmp/push-work` and retry |
