#!/usr/bin/env python3
"""
Script to extract images from PDF files in the Handouts folder.
Creates subfolders named after each PDF file and extracts images into them.
"""

import os
import sys
import fitz  # PyMuPDF

def extract_images_from_pdf(pdf_path, output_folder):
    """
    Extract all images from a PDF file and save them to the output folder.
    
    Args:
        pdf_path: Path to the PDF file
        output_folder: Path to the folder where images will be saved
    
    Returns:
        Number of images extracted
    """
    # Create output folder if it doesn't exist
    os.makedirs(output_folder, exist_ok=True)
    
    # Open the PDF
    pdf_document = fitz.open(pdf_path)
    image_count = 0
    
    # Iterate through each page
    for page_num in range(len(pdf_document)):
        page = pdf_document[page_num]
        
        # Get images on the page
        image_list = page.get_images()
        
        # Extract each image
        for img_index, img in enumerate(image_list):
            xref = img[0]  # Get the XREF of the image
            
            # Extract the image
            base_image = pdf_document.extract_image(xref)
            image_bytes = base_image["image"]
            image_ext = base_image["ext"]
            
            # Generate filename
            image_filename = f"page{page_num + 1}_img{img_index + 1}.{image_ext}"
            image_path = os.path.join(output_folder, image_filename)
            
            # Save the image
            with open(image_path, "wb") as image_file:
                image_file.write(image_bytes)
            
            image_count += 1
            print(f"  Extracted: {image_filename}")
    
    pdf_document.close()
    return image_count

def main():
    """Main function to process all PDF files in the Handouts folder."""
    # Get the directory where this script is located
    script_dir = os.path.dirname(os.path.abspath(__file__))
    
    # Find all PDF files in the current directory
    pdf_files = [f for f in os.listdir(script_dir) if f.endswith('.pdf')]
    
    if not pdf_files:
        print("No PDF files found in the Handouts folder.")
        return
    
    print(f"Found {len(pdf_files)} PDF file(s) to process.\n")
    
    # Process each PDF file
    total_images = 0
    for pdf_file in sorted(pdf_files):
        pdf_path = os.path.join(script_dir, pdf_file)
        
        # Create output folder name (remove .pdf extension)
        pdf_name = os.path.splitext(pdf_file)[0]
        output_folder = os.path.join(script_dir, pdf_name)
        
        print(f"Processing: {pdf_file}")
        
        try:
            image_count = extract_images_from_pdf(pdf_path, output_folder)
            total_images += image_count
            
            if image_count == 0:
                print(f"  No images found in {pdf_file}")
                # Remove empty folder if no images were extracted
                if os.path.exists(output_folder) and not os.listdir(output_folder):
                    os.rmdir(output_folder)
            else:
                print(f"  Total images extracted: {image_count}")
        except Exception as e:
            print(f"  Error processing {pdf_file}: {e}")
        
        print()
    
    print(f"Total images extracted from all PDFs: {total_images}")

if __name__ == "__main__":
    main()
