terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"  # Change this if needed
}

# 1️⃣ Create S3 Bucket for Static Website
resource "aws_s3_bucket" "resume_bucket" {
  bucket = "lenon-resume-website"  # Change to a unique bucket name
}

# 2️⃣ Enable Website Hosting
resource "aws_s3_bucket_website_configuration" "resume_website" {
  bucket = aws_s3_bucket.resume_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}

# 3️⃣ Configure Public Read Access
resource "aws_s3_bucket_policy" "resume_policy" {
  bucket = aws_s3_bucket.resume_bucket.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.resume_bucket.arn}/*"
      }
    ]
  })
}

# 4️⃣ Upload Static Website Files
resource "aws_s3_object" "index_html" {
  bucket      = aws_s3_bucket.resume_bucket.id
  key         = "index.html"
  source      = "index.html"
  content_type = "text/html"
}

resource "aws_s3_object" "style_css" {
  bucket      = aws_s3_bucket.id
  key         = "style.css"
  source      = "style.css"
  content_type = "text/css"
}

resource "aws_s3_object" "index_js" {
  bucket      = aws_s3_bucket.id
  key         = "index.js"
  source      = "index.js"
  content_type = "application/javascript"
}

resource "aws_s3_object" "profile_img" {
  bucket      = aws_s3_bucket.id
  key         = "profile.jpg"
  source      = "profile.jpg"
  content_type = "image/jpeg"
}

# 5️⃣ Output Website URL
output "website_url" {
  value = "http://${aws_s3_bucket.resume_bucket.bucket}.s3-website-${var.aws_region}.amazonaws.com"
}
