from reportlab.lib.pagesizes import letter
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
from reportlab.lib.units import inch
from reportlab.lib.colors import HexColor
from reportlab.platypus import SimpleDocTemplate, Paragraph, Spacer, ListFlowable, ListItem

doc = SimpleDocTemplate("/sessions/kind-festive-tesla/mnt/Jeffrey River/Pre-Release_Copyright_PRO_Checklist.pdf",
                        pagesize=letter, topMargin=0.6*inch, bottomMargin=0.6*inch,
                        leftMargin=0.75*inch, rightMargin=0.75*inch)

styles = getSampleStyleSheet()
title_style = ParagraphStyle('Title', parent=styles['Title'], fontSize=18, textColor=HexColor('#1a3d5c'), spaceAfter=6)
sub_style = ParagraphStyle('Sub', parent=styles['Normal'], fontSize=10, textColor=HexColor('#555555'), spaceAfter=14)
h2 = ParagraphStyle('H2', parent=styles['Heading2'], fontSize=13, textColor=HexColor('#1a3d5c'), spaceBefore=12, spaceAfter=6)
body = ParagraphStyle('Body', parent=styles['Normal'], fontSize=10.5, leading=14, spaceAfter=4)
note = ParagraphStyle('Note', parent=styles['Normal'], fontSize=9.5, textColor=HexColor('#666666'), leading=13, spaceAfter=6)

story = []
story.append(Paragraph("Pre-Release Copyright &amp; PRO Checklist", title_style))
story.append(Paragraph("For Jeffrey River — Acoustic Folk Singer-Songwriter | Sandpoint, ID", sub_style))

def section(title, items, note_text=None):
    story.append(Paragraph(title, h2))
    bullets = [ListItem(Paragraph(i, body), leftIndent=10) for i in items]
    story.append(ListFlowable(bullets, bulletType='bullet', start='square', leftIndent=18))
    if note_text:
        story.append(Paragraph(note_text, note))

section("Step 1 — Prepare Your Works (Before Filing)", [
    "Finalize demo recordings (MP3 or WAV) for each song you want protected.",
    "Type up clean lyric sheets for each song (PDF or Word).",
    "Save a master folder: one subfolder per song with audio + lyrics + writing notes.",
    "Confirm you are the sole author — or list all co-writers &amp; their splits.",
])

section("Step 2 — Register Copyright (U.S. Copyright Office)", [
    "Go to <b>copyright.gov</b> → click \"Register a Copyright\" → eCO login.",
    "Create an account (free).",
    "Choose application type: <b>Group of Unpublished Works</b> (GRUW) — up to 10 songs, one fee.",
    "Select work type: <b>Sound Recording + Musical Work</b> (covers both composition and recording if you own both).",
    "Pay fee: <b>$85</b> (group) or <b>$45</b> (single work).",
    "Upload audio files + lyric sheets for each song.",
    "Submit and save confirmation email + case number.",
], "Protection is effective from the filing date, even though certificate takes a few months.")

section("Step 3 — Register with a PRO (Performance Royalties)", [
    "Pick one: <b>ASCAP</b> ($50 one-time) or <b>BMI</b> (free).",
    "Register as both a <b>Writer</b> and a <b>Publisher</b> (you keep 100% if self-published).",
    "Add each song to your PRO catalog (title, co-writers, splits).",
    "This collects royalties when your songs are played on radio, live venues, streaming, TV, etc.",
])

section("Step 4 — Before You Distribute (Spotify/Apple/YouTube)", [
    "Pick a distributor: <b>DistroKid</b> (~$23/yr unlimited) or <b>TuneCore</b>.",
    "Set release date at least <b>3–4 weeks out</b> for Spotify editorial playlist pitching.",
    "Register song with <b>The MLC</b> (free) — collects mechanical royalties from streaming.",
    "Add <b>ISRC code</b> (distributor provides) and <b>ISWC code</b> (PRO provides).",
    "Claim your <b>Spotify for Artists</b> and <b>Apple Music for Artists</b> profiles.",
])

section("Step 5 — Ongoing Protection Habits", [
    "Date-stamp every new demo (email it to yourself or save to cloud with timestamp).",
    "File a new GRUW group registration every 6–12 months for new unreleased songs.",
    "Keep a running songwriter log: title, date written, co-writers, splits.",
    "Before any co-write session, agree on splits in writing (simple email is fine).",
])

story.append(Spacer(1, 10))
story.append(Paragraph("<b>Quick Cost Summary:</b> Copyright group $85 • PRO $0–$50 • MLC free • Distributor ~$23/yr", note))
story.append(Paragraph("<b>Bottom line:</b> File the group copyright <i>before</i> your single goes public. Everything else can happen in parallel.", note))

doc.build(story)
print("done")
