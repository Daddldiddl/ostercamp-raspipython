# Image Extraction from PDF Files

This folder contains PDF handouts for the Raspberry Pi Python course. Images have been extracted from these PDFs for easier access and use.

## Extracted Images

Images from each PDF file have been extracted into subfolders named after the PDF:

- **Tag1und2_GPIOs/** - 3 images from Tag1und2_GPIOs.pdf
- **Tag3_ADCs/** - 10 images from Tag3_ADCs.pdf
- **Tag4_PotiUndServo/** - 12 images from Tag4_PotiUndServo.pdf
- **VorabHandout_Ostercamp2025/** - 14 images from VorabHandout_Ostercamp2025.pdf
- **VorabHandout_Ostercamp2026/** - 13 images from VorabHandout_Ostercamp2026.pdf

Note: LinksUndResourcen.pdf contained no images.

## How to Re-extract Images

If you need to re-extract images or extract from new PDFs, use the `extract_images.py` script:

```bash
cd Handouts
python3 extract_images.py
```

### Requirements

The script requires PyMuPDF (fitz) library:

```bash
pip install PyMuPDF
```

### Image Naming Convention

Extracted images are named using the pattern: `page{N}_img{M}.{ext}`

- `{N}` is the page number (1-indexed)
- `{M}` is the image number on that page (1-indexed)
- `{ext}` is the image format (jpeg, png, etc.)

## Total Images

**52 images** extracted in total from 5 PDF files.
